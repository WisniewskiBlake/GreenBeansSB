//
//  VirtualStoreViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import Firebase
import UIKit
import FirebaseAuth

class VirtualStoreViewModel {
    var products = [Product]()
    var imageDictionary: [String:UIImage] = [:]
    private var user: User!
    private var userSession = AuthViewModel.shared.userSession
    private var images: [UIImage] = []
    static let sharedViewModel = VirtualStoreViewModel()
    
    init() {}
    
    func getProducts() -> [Product] {
        return self.products
    }
    
    func getImages() -> [String:UIImage] {
        return imageDictionary
    }
    
    func fetchAllProducts(category: String) {
        let query = self.provideQuery(category: category)
        query.getDocuments { (snapshot, error) in
             self.products = []
             self.images = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else { return }
             if !snapshot.isEmpty {
                 for productDictionary in snapshot.documents {
                     let productDictionary = productDictionary.data() as NSDictionary
                     let product = Product(dictionary: productDictionary as! [String : Any])
                     self.products.append(product)
                 }
             }
            if self.products.count == 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedStoreImages"), object: nil)
            } else {
                self.loadImages(products: self.products)
            }
        }
    }
    
    func loadImages(products: [Product]) {
        self.imageDictionary = [:]
        //if all else fails, put a condition to check if product.count ==0, do nothing
        for i in 0...products.count-1 {
            let str = products[i].productTitle
            let storageRef = Firebase.Storage.storage().reference(forURL: products[i].productImageUrl) 
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                print(error)
              } else {                
                // Data for "images/island.jpg" is returned
                self.imageDictionary[str] = UIImage(data: data!)!
                //self.images.append(UIImage(data: data!)!)
                if self.imageDictionary.count == self.products.count {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedStoreImages"), object: nil)                            
                }
              }
            }
        }
    }
    
    func addProductToCart(product: Product, quantity: String) {
        product.productDictionary[kPRODUCTQUANTITY] = quantity
        if userSession == nil {
            addToGuestCart(product: product, quantity: quantity)
        } else {
            addToUserCart(product: product, quantity: quantity)
        }
    }

    
    func addToGuestCart(product: Product, quantity: String) {
        guard let guestId = AuthViewModel.shared.user?.guestId else { return }
        let query = reference(.GuestUsers).document(guestId).collection("Cart").document(product.productTitle)
        query.getDocument { snapshot, _ in
            if let snapshot = snapshot, snapshot.exists {
                guard let data = snapshot.data() else { return }
                let oldProduct = Product(dictionary: data)
                let newQuantity = Int(quantity)! + Int(oldProduct.productQuantity)!
                product.productDictionary[kPRODUCTQUANTITY] = String(newQuantity)
                query.setData(product.productDictionary as! [String : Any])
            } else {
                query.setData(product.productDictionary as! [String : Any])
            }
        }
    }
    
    func addToUserCart(product: Product, quantity: String) {
        guard let email = AuthViewModel.shared.userSession?.email else { return }
        let query = reference(.Users).document(email).collection("Kart").document(product.productTitle)
        query.getDocument { snapshot, _ in
            if let snapshot = snapshot, snapshot.exists {
                guard let data = snapshot.data() else { return }
                let oldProduct = Product(dictionary: data)
                let newQuantity = Int(quantity)! + Int(oldProduct.productQuantity)!
                product.productDictionary[kPRODUCTQUANTITY] = String(newQuantity)
                query.setData(product.productDictionary as! [String : Any])                
            } else {
                query.setData(product.productDictionary as! [String : Any])
            }
        }
    }
    
    //TODO: notification center can be removed from here and replace with vm.fetchAllProducts
    
    func removeProduct(indexPath: IndexPath, product: Product) {
        //var query: DocumentChange?
        let query = reference(.Products).whereField(kPRODUCTTITLE, isEqualTo: product.productTitle)
        query.getDocuments { (snapshot, error) in
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else { return }
             if !snapshot.isEmpty {
                for document in snapshot.documents {
                    reference(.Products).document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "adminRemove"), object: nil)
                            print("Document successfully removed!")
                        }
                    }
                }
             }
        }
    }
    
    func editProduct(data: Data, name: String, price: String, discount: String, description: String, category: String, clothingSizes: String, imageChanged: Bool, product: Product) {
        var productDictionary: [String:Any] = [:]
        var highlightedProduct = "false"
        if discount != "0" {
            highlightedProduct = "true"
        }
        
        if imageChanged {
            let md = StorageMetadata()
            md.contentType = "image/jpeg"
            let replaced = name.replacingOccurrences(of: " ", with: "_")
            let path = "gs://greenbeans-9bcea.appspot.com/" + replaced + ".jpg"
            productDictionary = [
                "productImageUrl": path,
                "productTitle": name,
                "productPrice": price,
                "productType": category,
                "productDescription": description,
                "highlightedProduct": highlightedProduct,
                "highlightedDiscount": discount,
                "clothingSizes": clothingSizes
            ]
            let ref = Storage.storage().reference().child(replaced + ".jpg")
            ref.putData(data, metadata: md) { (metadata, error) in
                 if error == nil {
                     ref.downloadURL(completion: { (url, error) in
                         print("Done, url is \(String(describing: url))")
                        self.editProductHelper(productDictionary: productDictionary, product: product)
                     })
                 }else{
                     print("error \(String(describing: error))")
                 }
             }
//            reference(.Products).document().setData(productDictionary)
        } else {
            productDictionary = [
                "productTitle": name,
                "productPrice": price,
                "productType": category,
                "productDescription": description,
                "highlightedProduct": highlightedProduct,
                "highlightedDiscount": discount,
                "clothingSizes": clothingSizes
            ]
            self.editProductHelper(productDictionary: productDictionary, product: product)
        }
        
    }
    
    func editProductHelper(productDictionary: [String:Any], product: Product) {
        let query = reference(.Products).whereField(kPRODUCTTITLE, isEqualTo: product.productTitle)
        query.getDocuments { (snapshot, error) in
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else { return }
             if !snapshot.isEmpty {
                for document in snapshot.documents {
                    reference(.Products).document(document.documentID).updateData(productDictionary) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            self.fetchAllProducts(category: "All Products")
                            print("Document successfully updated!")
                        }
                    }
                }
             }
        }
    }
    
    private func provideQuery(category: String) -> Query {
        var query: Query?
        if(category != "All Products" && category != "On Sale") {
            query = reference(.Products).whereField(kPRODUCTTYPE, isEqualTo: category)
        } else if category == "On Sale" {
            query = reference(.Products).whereField(kPRODUCTDISCOUNT, isNotEqualTo: "")
        }
        return query ?? reference(.Products)
    }
    
    func setUser(user: User) {
        self.user = user
    }
}
