//
//  SideMenuViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var virtualStoreButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var orderHistoryButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var newAdminButton: UIButton!
    @IBOutlet weak var addRemoveProductsButton: UIButton!
    
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideButtons()
    }
    
    @IBAction func virtualStoreButtonClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "VirtualStore", animated: true, by: self, completion: nil)
    }
    
    @IBAction func cartButtonClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "Cart", animated: true, by: self, completion: nil)
    }
    
    @IBAction func orderHistoryButtonClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "OrderHistory", animated: true, by: self, completion: nil)
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        if AuthViewModel.shared.userSession != nil {
            AuthViewModel.shared.signOut()
        }
        helper.instantiateViewController(identifier: "Login", animated: true, by: self, completion: nil)
    }
    
    @IBAction func addRemoveClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "AddRemove", animated: true, by: self, completion: nil)
    }
    
    @IBAction func newAdminClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "NewAdmin", animated: true, by: self, completion: nil)
    }
    
    func hideButtons() {
        if AuthViewModel.shared.userSession == nil {
            signOutButton.setTitle("Login", for: .normal)            
        }
        if AuthViewModel.shared.user?.appManager == "false" {
            newAdminButton.isHidden = true
            addRemoveProductsButton.isHidden = true
        }
    }
}
