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
    
    init(user: User) {
        self.user = user
    }
    
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
        let uid = user.email
        product.productDictionary[kPRODUCTQUANTITY] = quantity
        reference(.Users).document(uid).collection("Kart").document(product.productTitle).setData(product.productDictionary as! [String : Any])
    }
    

    
    func provideQuery(category: String) -> Query {
        var query: Query?
        if(category != "All Products") {
            query = reference(.Products).whereField(kPRODUCTTYPE, isEqualTo: category)
        }
        return query ?? reference(.Products)
    }
}
