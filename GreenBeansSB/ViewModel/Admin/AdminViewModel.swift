//
//  AdminViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/4/21.
//

import Foundation
import Firebase
import UIKit
import FirebaseAuth

class AdminViewModel {
    var orders: [Order] = []
    
    func getOrders() -> [Order] {
        return self.orders
    }
    
    func addNewProduct(data: Data, name: String, price: String, discount: String, description: String, category: String, clothingSizes: String) {
        let replaced = name.replacingOccurrences(of: " ", with: "_")
        let path = "gs://greenbeans-9bcea.appspot.com/" + replaced + ".jpg"
        var highlightedProduct = "false"
        if discount != "0" {
            highlightedProduct = "true"
        }
        let productDictionary: [String:Any] = [
            "productImageUrl": path,
            "productTitle": name,
            "productPrice": price,
            "productType": category,
            "productDescription": description,
            "highlightedProduct": highlightedProduct,
            "highlightedDiscount": discount,
            "clothingSizes": clothingSizes
        ]
        let md = StorageMetadata()
        md.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference().child(replaced + ".jpg")
        ref.putData(data, metadata: md) { (metadata, error) in
             if error == nil {
                 ref.downloadURL(completion: { (url, error) in
                     print("Done, url is \(String(describing: url))")
                 })
             }else{
                 print("error \(String(describing: error))")
             }
         }
        reference(.Products).document().setData(productDictionary)
    } 
    
    func fetchCustomerOrders(filter: String) {
        let query = reference(.Orders).whereField(kORDERSTATUS, isEqualTo: filter)
        query.getDocuments { (snapshot, error) in
             self.orders = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else { return }
             if !snapshot.isEmpty {
                 for document in snapshot.documents {
                     let orderDictionary = document.data() as NSDictionary
                     let order = Order(dictionary: orderDictionary as! [String : Any])
                     order.orderId = document.documentID
                     self.orders.append(order)
                 }
             }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedOrders"), object: nil)
        }
    }    
}
