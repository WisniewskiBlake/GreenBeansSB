//
//  CartViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import Firebase

class CartViewModel: ObservableObject {
    var products = [Product]()
    var indexPath = IndexPath()
    
    
    init() { fetchUserCart() }
    
    func getCart() -> [Product] {
        return self.products
    }
    
    func fetchUserCart() {
        //guard let uid = AuthViewModel.shared.userSession?.email else { return }
        
        let query = reference(.Users).document("uid").collection("Kart")
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
    
    func removeProductFromCart(indexPath: IndexPath) {
        self.indexPath = indexPath
        let products = self.getCart()
        let product = products[indexPath.row]
        //guard let uid = AuthViewModel.shared.userSession?.email else { return }
        reference(.Users).document("uid").collection("Kart").document(product.productTitle).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.products.remove(at: indexPath.row)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "productRemoved"), object: nil)                
                print("Document successfully removed!")
            }
        }
    }
    
    func calculateTotal() -> String {
        var total: Double = 0.0
        for product in self.products {
            total = total + (Double(product.productPrice) ?? 0.0 * (Double(product.productQuantity) ?? 0.0))
        }
        return String(total)
    }
    
//    func productExistsInCart() -> Bool {
//        guard let uid = AuthViewModel.shared.userSession?.email else { return false }
//        reference(.Users).document(uid).collection("Kart").document(product.productTitle)
//    }
    
//    func addProductsToUserOrderHistory(products: [Product]) {
//        guard let uid = AuthViewModel.shared.userSession?.email else { return }
//        reference(.Users).document(uid).collection("OrderHistory").document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
//    
//    func addProductsToAdminOrderHistory(product: Product) {
//        reference(.Orders).document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
}

