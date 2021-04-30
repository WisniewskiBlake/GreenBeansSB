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
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(systemName: "envelope")
        let view = CustomTextField().inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(systemName: "lock")
        let view = CustomTextField().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
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
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor,
                           right: emailTextField.rightAnchor, paddingTop: 10, paddingLeft: 0, height: 0.75)
        let dividerViewPass = UIView()
        dividerViewPass.backgroundColor = .white
        view.addSubview(dividerViewPass)
        dividerViewPass.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor,
                           right: passwordTextField.rightAnchor, paddingTop: 10, paddingLeft: 0, height: 0.75)
        
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
    
    @objc func goToStore() {
        self.performSegue(withIdentifier: "VirtualStore", sender: self)
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    @IBAction func guestLoginButtonClicked(_ sender: Any) {
        viewModel.createGuestUser()
        performSegue(withIdentifier: "VirtualStore", sender: self)
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
