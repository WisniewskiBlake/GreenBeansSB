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
    
    let imageTapGestureRecognizer = UITapGestureRecognizer()
    let imagePickerVC = UIImagePickerController()
    var pictureToUpload: String? = ""
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
        if(productNameText.text != "" || productNameText.text != "Product Name" && productPriceText.text != "" || productPriceText.text != "Product Price" && productDescriptionText.text != "" || productDescriptionText.text != "Description") {
            let productName = productNameText.text
            let productPrice = productPriceText.text
            var discount = productDiscount.text
            let productDescription = productDescriptionText.text
            if productDiscount.text == "" || productDiscount.text == " " || productDiscount.text == "0" || productDiscount.text == "Percent Discount" {
                discount = "0"
            }
            let alertview = JSSAlertView().show(self,
              title: "Added New Product!",
              buttonText: "Ok"
            )
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font

        } else {
            helper.showAlert(title: "Please Enter Name, Price, and Description", message: "", in: self)
        }
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
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
