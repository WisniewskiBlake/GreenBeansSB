//
//  OrderHistoryViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/22/21.
//

import Firebase
import CoreLocation

class OrderHistoryViewModel: ObservableObject {
    private var userSession = AuthViewModel.shared.userSession
    var products = [Product]()
    var orders = [Order]()    
    
    init() { fetchOrderHistory() }
    
    func getProducts() -> [Product] {
        return self.products
    }
    
    func getOrders() -> [Order] {
        return self.orders
    }
    
    func fetchOrderHistory() {
        let query: CollectionReference?
        if userSession == nil {
            guard let guestId = AuthViewModel.shared.user?.guestId else { return }
            query = reference(.GuestUsers).document(guestId).collection("OrderHistory")
        } else {
            guard let email = userSession?.email else { return }
            query = reference(.Users).document(email).collection("OrderHistory")
        }
        query?.getDocuments { (snapshot, error) in
            self.products = []
            self.orders = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else {
                  return
             }
             if !snapshot.isEmpty {
                 for orderDictionary in snapshot.documents {
                     let orderDictionary = orderDictionary.data() as NSDictionary
                     let order = Order(dictionary: orderDictionary as! [String : Any])
                     self.orders.append(order)
                 }
             }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedHistory"), object: nil)
        }
    }
    
}
