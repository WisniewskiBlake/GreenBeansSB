//
//  GuestAddressViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit
import JSSAlertView

class GuestAddressViewController: UIViewController {
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var viewModel = AddressViewModel()
    var order: Order?
    var cartViewModel: CartViewModel?
    var pickUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pickUp == true {
            addressTextField.isHidden = true
        } else {
            addressTextField.isHidden = false
        }
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
        if addressTextField.isHidden {
            if emailTextField.text == "" || phoneTextField.text == "" {
                let alertview = JSSAlertView().show(self,
                  title: "Field is empty!",
                  buttonText: "Ok"
                )
                alertview.setTitleFont("ClearSans-Bold") // Title font
                alertview.setTextFont("ClearSans") // Alert body text font
                alertview.setButtonFont("ClearSans-Light") // Button text font
            } else {
                order?.userEmail = emailTextField.text!
                order?.userPhone = phoneTextField.text!
                performSegue(withIdentifier: "OrderSummary", sender: self)
            }
            
            
        }else {
            if addressTextField.text!.isEmpty || addressTextField.text == "" || emailTextField.text == "" || phoneTextField.text == "" {
                let alertview = JSSAlertView().show(self,
                  title: "Field is empty!",
                  buttonText: "Ok"
                )
                alertview.setTitleFont("ClearSans-Bold") // Title font
                alertview.setTextFont("ClearSans") // Alert body text font
                alertview.setButtonFont("ClearSans-Light") // Button text font
            } else {
                order?.customerAddress = addressTextField.text!
                order?.userEmail = emailTextField.text!
                order?.userPhone = phoneTextField.text!
                performSegue(withIdentifier: "OrderSummary", sender: self)
            }
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderSummary", let userAddressViewController = segue.destination as? OrderSummaryViewController {
            userAddressViewController.cartViewModel = cartViewModel
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
    }
}
