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

    private var viewModel = AddressViewModel()
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continueButtonClicked(_ sender: Any) {
        if addressTextField.text!.isEmpty || addressTextField.text == "" {
            let alertview = JSSAlertView().show(self,
              title: "Field is empty!",
              buttonText: "Ok"
            )
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            order?.address = addressTextField.text!
            performSegue(withIdentifier: "OrderSummary", sender: self)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderSummary", let userAddressViewController = segue.destination as? OrderSummaryViewController {
            
            userAddressViewController.order = order
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
    }

}
