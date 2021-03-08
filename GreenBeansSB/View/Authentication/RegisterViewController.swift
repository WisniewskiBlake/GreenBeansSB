//
//  RegisterViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let viewModel = AuthViewModel()
    private let customView = CustomView()
    private let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        customView.padding(for: emailTextField)
        customView.color(for: emailTextField)
        customView.cornerRadius(for: emailTextField)
        
        customView.padding(for: fullNameTextField)
        customView.color(for: fullNameTextField)
        customView.cornerRadius(for: fullNameTextField)
        
        customView.padding(for: addressTextField)
        customView.color(for: addressTextField)
        customView.cornerRadius(for: addressTextField)
        
        customView.padding(for: passwordTextField)
        customView.color(for: passwordTextField)
        customView.cornerRadius(for: passwordTextField)
        
        customView.cornerRadius(for: signUpButton)        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if helper.isValid(email: emailTextField.text!) == false {
            helper.showAlert(title: "Invalid Email", message: "Please enter registered Email address", in: self)
            return
        } else if passwordTextField.text!.count < 6 {
            helper.showAlert(title: "Invalid Password", message: "Password must contain at least 6 characters", in: self)
            return
        } else {
            viewModel.registerUser(email: emailTextField.text!, password: passwordTextField.text!, fullname: fullNameTextField.text!, address: addressTextField.text!) { (error)  in
                if error != nil {                    
                    self.helper.showAlert(title: "Email In Use", message: "", in: self)
                    return
                }
                self.goToApp()
            }
        }
    }
    
    func goToApp() {
        helper.instantiateViewController(identifier: "VirtualStore", animated: true, by: self, completion: nil)
    }
}
