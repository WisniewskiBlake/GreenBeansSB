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
    
    var addressViewModel: AddressViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(goToUserAddresses), name: NSNotification.Name(rawValue: "newAddress"), object: nil)
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
            addressViewModel?.addNewUserAddress(address: addressTextField.text!)            
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
