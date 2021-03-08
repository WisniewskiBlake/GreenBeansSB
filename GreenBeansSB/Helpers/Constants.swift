//
//  Constants.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import Firebase

let COLLECTION_ORDERS = Firestore.firestore().collection("Orders")
let COLLECTION_PRODUCTS = Firestore.firestore().collection("Products")
let COLLECTION_USERS = Firestore.firestore().collection("Users")

let kPRODUCTTITLE = "productTitle"
let kPRODUCTDESCRIPTION = "productDescription"
let kPRODUCTPRICE = "productPrice"
let kPRODUCTTYPE = "productType"
let kPRODUCTIMAGEURL = "productImageUrl"
let kPRODUCTQUANTITY = "productQuantity"
let kPRODUCTHIGHLIGHTED = "productHighlighted"


