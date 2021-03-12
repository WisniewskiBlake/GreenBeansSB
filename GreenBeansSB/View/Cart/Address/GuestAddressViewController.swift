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
    var order: Order?
    private var addresses: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
