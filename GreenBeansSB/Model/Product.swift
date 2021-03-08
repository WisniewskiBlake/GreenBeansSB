//
//  Product.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import Firebase

class Product {
    let productTitle: String
    let productDescription: String
    let productPrice: String
    let productType: String
    let productImageUrl: String
    var productQuantity: String
    let productHighlighted: String
    
    let productDictionary: NSMutableDictionary
        
    init(dictionary: [String: Any]) {
        self.productHighlighted = dictionary["productHighlighted"] as? String ?? ""
        self.productDescription = dictionary["productDescription"] as? String ?? ""
        self.productTitle = dictionary["productTitle"] as? String ?? ""
        self.productPrice = dictionary["productPrice"] as? String ?? ""
        self.productType = dictionary["productType"] as? String ?? ""
        self.productImageUrl = dictionary["productImageUrl"] as? String ?? ""
        self.productQuantity = dictionary["productQuantity"] as? String ?? ""
        
        productDictionary = NSMutableDictionary(objects: [productTitle, productDescription, productPrice, productType, productImageUrl, productQuantity, productHighlighted], forKeys: [kPRODUCTTITLE as NSCopying, kPRODUCTDESCRIPTION as NSCopying, kPRODUCTPRICE as NSCopying, kPRODUCTTYPE as NSCopying, kPRODUCTIMAGEURL as NSCopying, kPRODUCTQUANTITY as NSCopying, kPRODUCTHIGHLIGHTED as NSCopying])
    }
    
    init() {
        self.productHighlighted = ""
        self.productDescription = ""
        self.productTitle = ""
        self.productPrice = ""
        self.productType = ""
        self.productImageUrl = ""
        self.productQuantity = ""
        self.productDictionary = [:]
    }
}
