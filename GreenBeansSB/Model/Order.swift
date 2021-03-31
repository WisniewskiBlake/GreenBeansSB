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
    var customerAddress: String
    var pickUpAddress: String
    var orderTime: String
    var orderType: String
    var userEmail: String
    var userPhone: String
    var orderStatus: String
    var fullName: String
    var archived: String
    var pickUpTime: String
    var specialInstructions: String
    var deliveryFee: String
    var products: [String]
    
    let orderDictionary: NSMutableDictionary

    init(dictionary: [String: Any]) {
        self.customerAddress = dictionary["address"] as? String ?? ""
        self.subtotal = dictionary["subtotal"] as? String ?? ""
        self.tax = dictionary["tax"] as? String ?? ""
        self.orderTime = dictionary["orderTime"] as? String ?? ""
        self.orderType = dictionary["orderType"] as? String ?? ""
        self.userEmail = dictionary["userEmail"] as? String ?? ""
        self.userPhone = dictionary["userPhone"] as? String ?? ""
        self.orderStatus = dictionary[kORDERSTATUS] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.archived = dictionary["archived"] as? String ?? ""
        self.total = dictionary["total"] as? String ?? ""
        self.pickUpAddress = dictionary["pickUpAddress"] as? String ?? ""
        self.pickUpTime = dictionary["pickUpTime"] as? String ?? ""
        self.specialInstructions = dictionary["specialInstructions"] as? String ?? ""
        self.deliveryFee = dictionary["deliveryFee"] as? String ?? ""
        self.products = dictionary[kPRODUCTS] as? [String] ?? []
        
        orderDictionary = NSMutableDictionary(objects: [customerAddress, subtotal, tax, orderTime, orderType, userEmail, userPhone, orderStatus, fullName, archived, total, pickUpAddress, pickUpTime, specialInstructions, deliveryFee, products], forKeys: [kORDERADDRESS as NSCopying, kORDERSUBTOTAL as NSCopying, kORDERTAX as NSCopying, kORDERTIME as NSCopying, kORDERTYPE as NSCopying, kORDEREMAIL as NSCopying, kORDERPHONE as NSCopying, kORDERSTATUS as NSCopying, kORDERFULLNAME as NSCopying, kORDERARCHIVED as NSCopying, kORDERTOTAL as NSCopying, kORDERPICKUPADDRESS as NSCopying, kORDERPICKUPTIME as NSCopying, kORDERINSTRUCTIONS as NSCopying, kORDERDELIVERYFEE  as NSCopying, kPRODUCTS  as NSCopying])
    }
    
    init() {
        self.customerAddress = ""
        self.subtotal = ""
        self.tax = ""
        self.orderTime = ""
        self.orderType = ""
        self.userEmail = ""
        self.userPhone = ""
        self.orderStatus = ""
        self.fullName = ""
        self.archived = ""
        self.products = []
        self.total = ""
        self.orderDictionary = [:]
        self.pickUpAddress = ""
        self.pickUpTime = ""
        self.specialInstructions = ""
        self.deliveryFee = ""
    }
}
