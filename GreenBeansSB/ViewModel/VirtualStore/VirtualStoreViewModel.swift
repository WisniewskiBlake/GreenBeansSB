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
    
    init() {}
    
    func getProducts() -> [Product] {
        return self.products
    }
    
    func getImages() -> [String:UIImage] {
        return imageDictionary
    }
    
    func fetchAllProducts(category: String, vc: String) {
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
            if vc == "Store" {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedStoreProducts"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedAdminProducts"), object: nil)
            }
        }
    }
    
    func loadImages(products: [Product], vc: String) {
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
                    if vc == "Store" {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedStoreImages"), object: nil)
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedAdminImages"), object: nil)
                    }                 
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
    
    func provideQuery(category: String) -> Query {
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
