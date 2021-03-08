//
//  LoginViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var guestLoginBtn: UIButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var registerAccBtn: UIButton!
    @IBOutlet weak var textFieldsView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let viewModel: AuthViewModel = AuthViewModel()
    private let helper = Helper()
    private let customView = CustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        customView.padding(for: emailTextField)
        customView.padding(for: passwordTextField)
        customView.cornerRadius(for: emailTextField)
        customView.cornerRadius(for: passwordTextField)
        
        customView.cornerRadius(for: loginBtn)
        customView.cornerRadius(for: guestLoginBtn)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if helper.isValid(email: emailTextField.text!) == false {
            helper.showAlert(title: "Invalid Email", message: "Please enter registered Email address", in: self)
            return
        } else if passwordTextField.text!.count < 6 {
            helper.showAlert(title: "Invalid Password", message: "Password must contain at least 6 characters", in: self)
            return
        } else {
            viewModel.login(withEmail: emailTextField.text!, password: passwordTextField.text!)
            self.goToApp()
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        helper.instantiateViewController(identifier: "Register", animated: true, by: self, completion: nil)
    }
    
    @IBAction func guestLoginButtonClicked(_ sender: Any) {
        
    }
    
    func goToApp() {
        helper.instantiateViewController(identifier: "VirtualStore", animated: true, by: self, completion: nil)
    }    

}
