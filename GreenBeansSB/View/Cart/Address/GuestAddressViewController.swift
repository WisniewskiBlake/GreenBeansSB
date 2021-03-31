//
//  GuestAddressViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit
import JSSAlertView

class GuestAddressViewController: UIViewController {
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityStateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    private var addressViewModel = AddressViewModel()
    var order: Order?
    var cartViewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadedFee), name: NSNotification.Name(rawValue: "calculatedFee"), object: nil)
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        if streetAddressTextField.text == "" || cityStateTextField.text == "" || zipCodeTextField.text == "" {
            let alertview = JSSAlertView().show(self,
              title: "One or more fields are empty!",
              buttonText: "Ok"
            )
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            let fullAddress = streetAddressTextField.text! + ", " + cityStateTextField.text! + " " + zipCodeTextField.text!
            DispatchQueue.main.async {
                self.addressViewModel.getCoordinate(addressString: fullAddress, completionHandler: { (coordinate, error) -> Void in
                    if error == nil {
                        self.addressViewModel.calcDeliveryFee(endCoordinate: coordinate)
                        self.order?.customerAddress = fullAddress
                    }
                })
            }            
        }
    }
    
    @objc func loadedFee() {        
        order?.deliveryFee = addressViewModel.getDeliveryFee()
        performSegue(withIdentifier: "ContactInfo", sender: self)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactInfo", let guestContactVC = segue.destination as? GuestContactViewController {
            guestContactVC.cartViewModel = cartViewModel
            guestContactVC.order = order
            guestContactVC.modalPresentationStyle = .fullScreen
        }
    }
}
