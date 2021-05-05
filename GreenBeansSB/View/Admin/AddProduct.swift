//
//  AddProduct.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/4/21.
//

import UIKit

import UIKit
import JSSAlertView


class AddProduct: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var productDiscount: UITextField!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var cellText = "Category"
    
    let imageTapGestureRecognizer = UITapGestureRecognizer()
    let imagePickerVC = UIImagePickerController()
    var pictureToUpload: String? = ""
    let viewModel = AdminViewModel()
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTapGestureRecognizer.addTarget(self, action: #selector(self.handleImageTap))
        productImage.isUserInteractionEnabled = true
        productImage.addGestureRecognizer(imageTapGestureRecognizer)
        productNameText.delegate = self
        productPriceText.delegate = self
        productDiscount.delegate = self
        productDescriptionText.delegate = self
        
    }
    
    @IBAction func addProductClicked(_ sender: Any) {
        if(productNameText.text != "" || productNameText.text != "Product Name" && productPriceText.text != "" || productPriceText.text != "Product Price" && productDescriptionText.text != "" || productDescriptionText.text != "Description" && productDiscount.text != "") {
            let productName = productNameText.text
            let productPrice = productPriceText.text
            let discount = Int(productDiscount.text!) ?? 0
            let productDescription = productDescriptionText.text
            
            viewModel.addNewProduct(image: pictureToUpload!, name: productName!, price: productPrice!, discount: String(discount), description: productDescription!)
            
            let alertview = JSSAlertView().show(self,
              title: "Added New Product!",
              buttonText: "Ok"
            )
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font

        } else {
            helper.showAlert(title: "Please Fill All Fields", message: "", in: self)
        }
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        dataSource = ["Clothing", "Concentrate", "Edible", "Supplies"]
        selectedButton = categoryButton
        addTransparentView(frames: categoryButton.frame)
    }
    
    @objc func handleImageTap() {
        showActionSheet()
    }
    
    func showActionSheet() {
        // declaring action sheet
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // declaring library button
        let library = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            // checking availability of photo library
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.showPicker(with: .photoLibrary)
            }
        }
        // declaring cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // adding buttons to the sheet
        sheet.addAction(library)
        sheet.addAction(cancel)
        // present action sheet to the user finally
        self.present(sheet, animated: true, completion: nil)
    }
    
    func showPicker(with source: UIImagePickerController.SourceType) {
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[UIImagePickerController.InfoKey(rawValue: convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage))] as? UIImage
        let picturePath = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

            // assign selected image to AvaImageView
        self.productImage.image = picturePath

            // refresh global variable storing the user's profile pic
        let pictureData = image?.jpegData(compressionQuality: 0.4)!
        let avatar = pictureData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        pictureToUpload = avatar


        dismiss(animated: true) {}
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
         return true
    }
    
    func textViewShouldReturn(_ textField: UITextView) -> Bool {
        self.view.endEditing(true)
         return true
    }
    
    func addTransparentView(frames: CGRect) {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        
        transparentView.frame = keyWindow?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
