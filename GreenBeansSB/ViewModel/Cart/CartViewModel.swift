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
    private var userSession = AuthViewModel.shared.userSession
    let helper = Helper()
    
    init() { fetchUserCart() }
    
    func getCart() -> [Product] {
        return self.products
    }
    
    func fetchUserCart() {
        let query: CollectionReference?
        if userSession == nil {
            guard let guestId = AuthViewModel.shared.user?.guestId else { return }
            query = reference(.GuestUsers).document(guestId).collection("Cart")   
        } else {
            guard let email = userSession?.email else { return }
            query = reference(.Users).document(email).collection("Kart")
        }
        query?.getDocuments { (snapshot, error) in
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
        let document: DocumentReference?
        self.indexPath = indexPath
        let products = self.getCart()
        let product = products[indexPath.row]
        if userSession == nil {
            guard let guestId = AuthViewModel.shared.user?.guestId else { return }
            document = reference(.GuestUsers).document(guestId).collection("Cart").document(product.productTitle)
        } else {
            guard let email = userSession?.email else { return }
            document = reference(.Users).document(email).collection("Kart").document(product.productTitle)
        }
        document?.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.products.remove(at: indexPath.row)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "productRemoved"), object: nil)
                print("Document successfully removed!")
            }
        }
    }
    
    func calculateDelivery(address: String) -> String? {
        return ""
    }
    
    func placeOrder(order: Order?) {
        if userSession == nil {
            placeGuestOrder(order: order)
        } else {
            placeUserOrder(order: order)
        }
    }
    
    func placeUserOrder(order: Order?) {
        guard let email = AuthViewModel.shared.userSession?.email else { return }
        let ref = reference(.Users).document(email).collection("OrderHistory")
        let orderID = ref.document().documentID
        
        ref.document(orderID).setData(order!.orderDictionary as! [String : Any])
        for product in order!.products {
            ref.document(orderID).collection("Product").document().setData(product.productDictionary as! [String : Any])
        }
    }
    
    func placeGuestOrder(order: Order?) {
        guard let guestId = AuthViewModel.shared.user?.guestId else { return }
        let ref = reference(.GuestUsers).document(guestId).collection("OrderHistory")
        let orderID = ref.document().documentID
        let data = ["customerAddress": order?.customerAddress,
                    "subtotal": order?.subtotal,
                    "tax": order?.tax,
                    "orderTime": helper.getCurrentDate(),
                    "orderType": order?.orderType,
                    "userEmail": order?.userEmail,
                    "userPhone": order?.userPhone,
                    "fullName": "",
                    "archived": "false",
                    "total": order?.total,
                    "pickUpAddress": order?.pickUpAddress
                    ]
        ref.document(orderID).setData(data as [String : Any])
        for product in order!.products {
            ref.document(orderID).collection("Product").document().setData(product.productDictionary as! [String : Any])
        }
    }
//    
//    func addProductsToAdminOrderHistory(order: Order?) {
//        reference(.Orders).document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
    
    func calculateTax(subtotal: String) -> String {
        let tax = Double(subtotal)! * 0.07
        let roundedTax = String(format: "%.2f", tax)
        return String(roundedTax)
    }
    
    func calculateSubtotal(productList: [Product]) -> String {
        var total: Double = 0.0
        for product in productList {
            total = total + Double(product.productPrice)! * Double(product.productQuantity + ".0")!
        }
        return String(total)
    }
    
    func calculateTotal(subtotal: String, tax: String) -> String {
        let total = Double(subtotal)! + Double(tax)!
        return String(format: "%.2f", total)
    }
    
    func userInSession() -> Bool? {
        if userSession == nil {
            return false
        } else {
            return true
        }
    }
}

