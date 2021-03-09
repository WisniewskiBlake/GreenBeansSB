//
//  Order.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import Foundation

class Order {
    var subtotal: String
    var total: String
    var tax: String
    var address: String
    var orderTime: String
    var orderType: String
    var userEmail: String
    var orderStatus: String
    var fullName: String
    var archived: String
    var products: [Product]

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
    
    init() {
        self.address = ""
        self.subtotal = ""
        self.tax = ""
        self.orderTime = ""
        self.orderType = ""
        self.userEmail = ""
        self.orderStatus = ""
        self.fullName = ""
        self.archived = ""
        self.products = []
        self.total = ""
    }
}
