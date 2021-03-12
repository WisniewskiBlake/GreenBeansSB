//
//  Address.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/11/21.
//

import Firebase

struct Address {
    let address: String?
    
    init(dictionary: [String: Any]) {
        self.address = dictionary["address"] as? String ?? ""        
    }
}
