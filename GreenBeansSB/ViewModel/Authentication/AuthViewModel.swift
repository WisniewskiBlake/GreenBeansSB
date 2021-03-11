//
//  AuthViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    var userSession: FirebaseAuth.User?
    var isAuthenticating = false
    var error: Error?
    var user: User?
    
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to login: \(error.localizedDescription)")
                    return
                }
                self.userSession = result?.user
                self.fetchUser()
            }
        }
    
    func registerUser(email: String, password: String, fullname: String, address: String, completion: @escaping (_ error: Error?) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let user = result?.user else { return }
            let data = ["email": email,
                        "address": address.lowercased(),
                        "fullName": fullname,
                        "appManager": "false"
                        ]
            reference(.Users).document(email).setData(data) { _ in
                self.userSession = user
                self.fetchUser()
            }
            completion(error)
        })        
    }
    
    func createGuestUser() {
        let ref = reference(.GuestUsers)
        let docId = ref.document().documentID
        let data = ["guestId": docId
                    ]
        
        ref.document(docId).setData(data) { _ in
            self.user = User(dictionary: data)            
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.email else { return }
        reference(.Users).document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loggedIn"), object: nil)
        }
    }
    
    func fetchUserAutoLogin(email: String) {
        reference(.Users).document(email).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "autoLoggedIn"), object: nil)
        }        
    }
    
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    func tabTitle(forIndex index: Int) -> String {
        switch index {
        case 0: return "Order"
        case 1: return "Virtual Store"
        case 2: return "Cart"
        case 3: return "Order History"
        default: return ""
        }
    }
}
