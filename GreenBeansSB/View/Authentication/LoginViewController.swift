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
    
    private let viewModel = AuthViewModel.shared
    private let helper = Helper()
    private let customView = CustomView()
    private var loginClicked = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(goToStore), name: NSNotification.Name(rawValue: "loggedIn"), object: nil)
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
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    @IBAction func guestLoginButtonClicked(_ sender: Any) {
        viewModel.createGuestUser()
        performSegue(withIdentifier: "VirtualStore", sender: self)
    }
    
    @objc func goToStore() {
        self.performSegue(withIdentifier: "VirtualStore", sender: self)
    }    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "VirtualStore", let virtualStoreViewController = segue.destination as? VirtualStoreViewController {
            virtualStoreViewController.modalPresentationStyle = .fullScreen           
        }
        if let destinationViewController = segue.destination as? RegisterViewController {
            destinationViewController.viewModel = viewModel
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }
}
