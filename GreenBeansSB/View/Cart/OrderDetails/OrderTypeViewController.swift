//
//  OrderTypeViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/11/21.
//

import UIKit

class OrderTypeViewController: UIViewController {
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    
    private let helper = Helper()
    var order: Order?
    var cartViewModel: CartViewModel?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTransitionRight()
    }
    
    @IBAction func pickUpButtonClicked(_ sender: Any) {
        order?.orderType = "pickUp"
        performSegue(withIdentifier: "PickUp", sender: self)
    }
    
    @IBAction func deliveryButtonClicked(_ sender: Any) {
        order?.orderType = "delivery"
        if (cartViewModel?.userInSession())! {
            performSegue(withIdentifier: "UserDelivery", sender: self)
        } else {
//            performSegue(withIdentifier: "GuestDelivery", sender: self)
            performSegue(withIdentifier: "GuestAddressSearch", sender: self)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickUp", let userAddressViewController = segue.destination as? TimeViewController {
            userAddressViewController.cartViewModel = cartViewModel
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "UserDelivery", let userAddressViewController = segue.destination as? UserAddressViewController {            
            userAddressViewController.cartViewModel = cartViewModel
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "GuestAddressSearch", let pickUpViewController = segue.destination as? GuestAutoAddr {
            pickUpViewController.cartViewModel = cartViewModel
            pickUpViewController.order = order
            pickUpViewController.modalPresentationStyle = .fullScreen
        }
    }
}
