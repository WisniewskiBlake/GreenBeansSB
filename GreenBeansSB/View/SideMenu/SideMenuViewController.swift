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
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    let helper = Helper()
    let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func settingsButtonClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "Settings", animated: true, by: self, completion: nil)
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        authViewModel.signOut()
        helper.instantiateViewController(identifier: "Login", animated: true, by: self, completion: nil)
    }
}
