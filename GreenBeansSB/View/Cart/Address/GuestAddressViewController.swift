//
//  GuestAddressViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit

class GuestAddressViewController: UIViewController {
    @IBOutlet weak var addressTextField: UITextField!

    private var viewModel = AddressViewModel()
    private var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setAddressText), name: NSNotification.Name(rawValue: "loadedAddress"), object: nil)
        viewModel.fetchUserAddress()
        // Do any additional setup after loading the view.
    }
    
    @objc func setAddressText() {
        address = viewModel.getAddress()
        addressTextField.text = address
    }
    

    @IBAction func continueButtonClicked(_ sender: Any) {
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
