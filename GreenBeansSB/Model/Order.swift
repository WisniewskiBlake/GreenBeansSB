//
//  Order.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import Foundation

class Order {
    let subtotal: String
    var total: String
    var tax: String
    let address: String
    let orderTime: String
    let orderType: String
    let userEmail: String
    let orderStatus: String
    let fullName: String
    let archived: String
    let products: [Product]

    init(dictionary: [String: Any]) {
        self.address = dictionary["address"] as? String ?? ""
        self.subtotal = dictionary["subtotal"] as? String ?? ""
        self.tax = dictionary["tax"] as? String ?? ""
        self.orderTime = dictionary["orderTime"] as? String ?? ""
        self.orderType = dictionary["orderType"] as? String ?? ""
        self.userEmail = dictionary["userEmail"] as? String ?? ""
        self.orderStatus = dictionary["orderStatus"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.archived = dictionary["archived"] as? String ?? ""
        self.products = (dictionary["Product"] as? [Product] ?? [])
        self.total = dictionary["total"] as? String ?? ""
    }
}
