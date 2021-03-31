//
//  GuestContactViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/18/21.
//

import UIKit
import JSSAlertView

class GuestContactViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    private var viewModel = AddressViewModel()
    var order: Order?
    var cartViewModel: CartViewModel?
    var pickUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
        if emailTextField.text == "" || phoneTextField.text == "" || fullNameTextField.text == "" {
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
            order?.fullName = fullNameTextField.text!
            performSegue(withIdentifier: "OrderSummary", sender: self)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderSummary", let orderSummaryVC = segue.destination as? OrderSummaryViewController {
            orderSummaryVC.cartViewModel = cartViewModel
            orderSummaryVC.order = order
            orderSummaryVC.modalPresentationStyle = .fullScreen
        }        
    }
}
