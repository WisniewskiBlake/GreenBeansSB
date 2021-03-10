//
//  AddressViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import Firebase

class AddressViewModel: ObservableObject {
    var address: String?
    
    init() {
        fetchUserAddress()
    }
    
    func getAddress() -> String {
        return self.address ?? ""
    }
    
    func fetchUserAddress() {
        //guard let uid = AuthViewModel.shared.userSession?.email else { return }
        reference(.Users).document("uid").getDocument { document, _ in
            if let document = document {
                self.address = document.get("address") as? String
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedAddress"), object: nil)
            } else {
                print("Document does not exist in cache")
            }            
        }
    }
    
    func addNewUserAddress(address: String) {
        
    }
    
    func setUserAddress(address: String) {
        self.address = address
    }
    
//    func addProductsToUserOrderHistory(products: [Product]) {
//        guard let uid = AuthViewModel.shared.userSession?.email else { return }
//        reference(.Users).document(uid).collection("OrderHistory").document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
//
//    func addProductsToAdminOrderHistory(product: Product) {
//        reference(.Orders).document().setData(<#T##documentData: [String : Any]##[String : Any]#>)
//    }
}
