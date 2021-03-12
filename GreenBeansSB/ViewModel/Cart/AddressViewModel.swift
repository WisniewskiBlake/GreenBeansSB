//
//  AddressViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import Firebase

class AddressViewModel: ObservableObject {
    var addresses: [String] = []
    var address: String?
    private var userSession = AuthViewModel.shared.userSession
    
    init() {
        fetchUserAddresses()
    }
    
    func getAddresses() -> [String] {
        return self.addresses
    }
    
    func fetchUserAddresses() {
        guard let email = userSession?.email else { return }
        let query = reference(.Users).document(email).collection("Address")
        query.getDocuments { (snapshot, error) in
            self.addresses = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else {
                  return
             }
             if !snapshot.isEmpty {
                 for addressDictionary in snapshot.documents {
                     let addressDictionary = addressDictionary.data() as NSDictionary
                     let address = Address(dictionary: addressDictionary as! [String : Any])
                    self.addresses.append(address.address!)
                 }
             }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedAddresses"), object: nil)
        }
    }
    
    func addNewUserAddress(address: String) {
        guard let email = userSession?.email else { return }
        let address = ["address": address.lowercased()]
        reference(.Users).document(email).collection("Address").addDocument(data: address)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newAddress"), object: nil)
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
