//
//  CartViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import Firebase
import CoreLocation

class CartViewModel: ObservableObject {
    var products = [Product]()
    var summaryProducts = [Product]()
    var indexPath = IndexPath()
    private var userSession = AuthViewModel.shared.userSession
    let helper = Helper()
    
    init() { fetchUserCart() }
    
    func getCart() -> [Product] {
        return self.products
    }
    
    func getSummaryProducts() -> [Product] {
        return self.summaryProducts
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
    
    func placeOrder(order: Order?) {
        if userSession == nil {
            placeGuestOrder(order: order)
        } else {
            placeUserOrder(order: order)
        }
    }
    
    func placeUserOrder(order: Order?) {
        guard let fullName = AuthViewModel.shared.user?.fullName else { return }
        guard let email = AuthViewModel.shared.userSession?.email else { return }
        let userRef = reference(.Users).document(email).collection("OrderHistory")
        let orderID = userRef.document().documentID
        let ordersRef = reference(.Orders).document(orderID)
//        for product in products {
//            order?.products.append(product.productTitle + ";" + product.productQuantity)
//        }
        let orderDictionary: [String : Any] = ["customerAddress": order?.customerAddress ?? "",
                    "subtotal": order?.subtotal ?? "",
                    "tax": order?.tax ?? "",
                    "orderTime": helper.getCurrentDate(),
                    "orderType": order?.orderType ?? "",
                    "userEmail": email,
                    "userPhone": order?.userPhone ?? "",
                    kORDERSTATUS: "PLACED",
                    "fullName": fullName,
                    "archived": "false",
                    "total": order?.total ?? "",
                    "pickUpAddress": order?.pickUpAddress ?? "",
                    "pickUpTime": order?.pickUpTime ?? "",
                    "specialInstructions": order?.specialInstructions ?? "",
                    "deliveryFee": order?.deliveryFee ?? "",
                    kPRODUCTS: order?.products ?? []]
                
        userRef.document(orderID).setData(orderDictionary)
        ordersRef.setData(orderDictionary as [String : Any])
        for product in products {
            reference(.Users).document(email).collection("Kart").document(product.productTitle).delete()
        }
    }
    
    func placeGuestOrder(order: Order?) {
        guard let guestId = AuthViewModel.shared.user?.guestId else { return }
        let guestUserRef = reference(.GuestUsers).document(guestId).collection("OrderHistory")
        let orderID = guestUserRef.document().documentID
        let ordersRef = reference(.Orders).document(orderID)
//        for product in products {
//            order?.products.append(product.productTitle + ";" + product.productQuantity)
//        }
        let orderDictionary: [String : Any] = ["customerAddress": order?.customerAddress ?? "",
                    "subtotal": order?.subtotal ?? "",
                    "tax": order?.tax ?? "",
                    "orderTime": helper.getCurrentDate(),
                    "orderType": order?.orderType ?? "",
                    "userEmail": order?.userEmail ?? "",
                    "userPhone": order?.userPhone ?? "",
                    kORDERSTATUS: "PLACED",
                    "fullName": order?.fullName ?? "",
                    "archived": "false",
                    "total": order?.total ?? "",
                    "pickUpAddress": order?.pickUpAddress ?? "",
                    "pickUpTime": order?.pickUpTime ?? "",
                    "specialInstructions": order?.specialInstructions ?? "",
                    "deliveryFee": order?.deliveryFee ?? "",
                    kPRODUCTS: order?.products ?? []]
        
        guestUserRef.document(orderID).setData(orderDictionary)
        ordersRef.setData(orderDictionary as [String : Any])
        for product in products {
            reference(.GuestUsers).document(guestId).collection("Cart").document(product.productTitle).delete()
        }
    }
    
    func fetchSummaryProducts(order: Order) {
        let productNames = getProductNames(order: order)
        summaryProducts = []
        for name in productNames {
            let query = reference(.Products).whereField(kPRODUCTTITLE, isEqualTo: name)            
            query.getDocuments { (snapshot, error) in
                 if error != nil {
                     print(error!.localizedDescription)
                     return
                 }
                 guard let snapshot = snapshot else { return }
                 if !snapshot.isEmpty {
                     for productDictionary in snapshot.documents {
                        let productDictionary = productDictionary.data() as NSDictionary
                        let product = Product(dictionary: productDictionary as! [String : Any])
                        self.summaryProducts.append(product)
                     }
                 }
            }
        }
        if summaryProducts.count == productNames.count {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "productsLoaded"), object: nil)
        }
    }
    
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
        let roundedSubtotal = String(format: "%.2f", total)
        return String(roundedSubtotal)
    }
    
    func calculateTotal(subtotal: String, tax: String, order: Order) -> String {
        var total: Double?
        if order.orderType == "Delivery" {
            total = Double(subtotal)! + Double(tax)! + Double(order.deliveryFee)!
        } else {
            total = Double(subtotal)! + Double(tax)!
        }
        
        return String(format: "%.2f", total!)
    }
    
    func userInSession() -> Bool? {
        if userSession == nil { return false }
        else { return true }
    }
    
    func getProductNames(order: Order) -> [String] {
        var productNames: [String] = []
        for product in order.products {
            var details = product.components(separatedBy: ";")
            productNames.append(details[0])
        }
        return productNames
    }
    
    func getProductQuantities(order: Order) -> [String] {
        var productQuantities: [String] = []
        for product in order.products {
            var details = product.components(separatedBy: ";")
            productQuantities.append(details[1])
        }
        return productQuantities
    }
}

