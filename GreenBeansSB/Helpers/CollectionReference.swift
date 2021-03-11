//
//  CollectionReference.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/14/1399 AP.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case Users
    case Products
    case Orders
    case GuestUsers
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
