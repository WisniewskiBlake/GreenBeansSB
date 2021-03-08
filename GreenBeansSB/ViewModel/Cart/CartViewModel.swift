//
//  CartViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import Firebase

class CartViewModel: ObservableObject {
    var products = [Product]()
    
    init() {
        fetchUserCart()
    }
    
    func getCart() -> [Product] {
        return self.products
    }
    
    func fetchUserCart() {
        guard let uid = AuthViewModel.shared.userSession?.email else { return }
        
        let query = reference(.Users).document(uid).collection("Kart")
        query.getDocuments { (snapshot, error) in
             self.products = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else {
                  return
             }
             if !snapshot.isEmpty {
                 for productDictionary in snapshot.documents {
                     let productDictionary = productDictionary.data() as NSDictionary
                     let product = Product(dictionary: productDictionary as! [String : Any])
                     self.products.append(product)
                 }
             }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedCart"), object: nil)
        }
    }
    
    func removeProductFromCart(product: Product) {
        guard let uid = AuthViewModel.shared.userSession?.email else { return }
        reference(.Users).document(uid).collection("Kart").document(product.productTitle).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
//    func addProductsToUserOrderHistory(products: [Product]) {
//        guard let uid = AuthViewModel.shared.userSession?.email else { return }
//        reference(.Users).document(uid).collection("OrderHistory").document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
//    
//    func addProductsToAdminOrderHistory(product: Product) {
//        reference(.Orders).document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
}

