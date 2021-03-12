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
        if (cartViewModel?.userInSession())! {
            performSegue(withIdentifier: "UserPickUp", sender: self)
        } else {
            performSegue(withIdentifier: "GuestPickUp", sender: self)
        }
    }
    
    @IBAction func deliveryButtonClicked(_ sender: Any) {
        order?.orderType = "delivery"
        if (cartViewModel?.userInSession())! {
            performSegue(withIdentifier: "UserDelivery", sender: self)
        } else {
            performSegue(withIdentifier: "GuestDelivery", sender: self)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserPickUp", let userAddressViewController = segue.destination as? UserAddressViewController {
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "UserDelivery", let userAddressViewController = segue.destination as? UserAddressViewController {
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "GuestPickUp", let guestAddressViewController = segue.destination as? GuestAddressViewController {
            guestAddressViewController.order = order
            guestAddressViewController.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "GuestDelivery", let guestAddressViewController = segue.destination as? GuestAddressViewController {
            guestAddressViewController.order = order
            guestAddressViewController.modalPresentationStyle = .fullScreen
        }
    }
}
