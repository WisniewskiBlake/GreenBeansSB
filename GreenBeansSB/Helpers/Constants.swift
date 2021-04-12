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
let COLLECTION_GUESTUSERS = Firestore.firestore().collection("GuestUsers")

let kPRODUCTTITLE = "productTitle"
let kPRODUCTDESCRIPTION = "productDescription"
let kPRODUCTPRICE = "productPrice"
let kPRODUCTTYPE = "productType"
let kPRODUCTIMAGEURL = "productImageUrl"
let kPRODUCTQUANTITY = "productQuantity"
let kPRODUCTHIGHLIGHTED = "highlightedProduct"
let kPRODUCTDISCOUNT = "highlightedDiscount"
let kPRODUCTSTATUS = "productStatus"

let kORDERSUBTOTAL = "subtotal"
let kORDERTAX = "tax"
let kORDERADDRESS = "address"
let kORDERPICKUPADDRESS = "pickUpAddress"
let kORDERTIME = "orderTime"
let kORDERTYPE = "orderType"
let kORDEREMAIL = "userEmail"
let kORDERPHONE = "userPhone"
let kORDERSTATUS = "orderStatus"
let kORDERFULLNAME = "fullName"
let kORDERARCHIVED = "archived"
let kORDERTOTAL = "total"
let kORDERPICKUPTIME = "pickUpTime"
let kORDERINSTRUCTIONS = "specialInstructions"
let kORDERDELIVERYFEE = "deliveryFee"
let kPRODUCTS = "orderDetails"



