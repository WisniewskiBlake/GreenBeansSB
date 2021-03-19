//
//  User.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import Firebase

struct User {
    let email: String
    let fullName: String
    let address: String
    let cart: [Product]
    let orderHistory: [Order]
    let phoneNumber: String
    let guestId: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.orderHistory = (dictionary["OrderHistory"] as? [Order] ?? [])
        self.cart = (dictionary["Kart"] as? [Product] ?? [])
        self.guestId = dictionary["guestId"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
    }
}
