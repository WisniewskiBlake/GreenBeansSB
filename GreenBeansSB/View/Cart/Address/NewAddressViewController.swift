//
//  NewAddressViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/12/21.
//

import UIKit
import JSSAlertView

class NewAddressViewController: UIViewController {
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityStateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    
    var addressViewModel: AddressViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(goToUserAddresses), name: NSNotification.Name(rawValue: "newAddress"), object: nil)
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        if addressTextField.text == "" || cityStateTextField.text == "" || zipTextField.text == "" {
            let alertview = JSSAlertView().show(self,
              title: "One or more fields are empty!",
              buttonText: "Ok"
            )
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            let fullAddress = addressTextField.text! + ", " + cityStateTextField.text! + " " + zipTextField.text!
            addressViewModel?.addNewUserAddress(address: fullAddress)
        }
    }
    
    @objc func goToUserAddresses() {
        performSegue(withIdentifier: "UserAddress", sender: self)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserAddress", let userAddressViewController = segue.destination as? UserAddressViewController {
            userAddressViewController.modalPresentationStyle = .fullScreen
        }
    }

}
