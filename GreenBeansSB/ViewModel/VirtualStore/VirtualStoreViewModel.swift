//
//  VirtualStoreViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import Firebase

class VirtualStoreViewModel {
    var products = [Product]()
    private var user: User!
    private var userSession = AuthViewModel.shared.userSession
    
    init() {}
    
    func getProducts() -> [Product] {
        return self.products
    }
    
    func fetchAllProducts(category: String) {
        let query = self.provideQuery(category: category)
        query.getDocuments { (snapshot, error) in
             self.products = []
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedProducts"), object: nil)
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
