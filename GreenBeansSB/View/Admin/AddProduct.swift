//
//  AddProduct.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/4/21.
//

import UIKit

import UIKit
import JSSAlertView
import Firebase

class CellClass: UITableViewCell {}

class AddProduct: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var productDiscount: UITextField!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var smallBtn: UIButton!
    @IBOutlet weak var medBtn: UIButton!
    @IBOutlet weak var largeBtn: UIButton!
    @IBOutlet weak var xlBtn: UIButton!
    @IBOutlet weak var xxlBtn: UIButton!
    
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var lLabel: UILabel!
    @IBOutlet weak var xlLabel: UILabel!
    @IBOutlet weak var xxlLabel: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var cellText = "Category"
    var clothingSizes = ""
    
    let imageTapGestureRecognizer = UITapGestureRecognizer()
    let imagePickerVC = UIImagePickerController()
    let viewModel = AdminViewModel()    
    let helper = Helper()
    var image = UIImage()
    var data = Data()
    var imageSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initButtons()
        imageTapGestureRecognizer.addTarget(self, action: #selector(self.handleImageTap))
        productImage.isUserInteractionEnabled = true
        productImage.addGestureRecognizer(imageTapGestureRecognizer)
        productNameText.delegate = self
        productPriceText.delegate = self
        productDiscount.delegate = self
        productDescriptionText.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func addProductClicked(_ sender: Any) {
        if fieldsValid() {
            checkClothingSizes()
            let productName = productNameText.text
            let productPrice = productPriceText.text
            var discount = productDiscount.text ?? "0"
            if discount == "$0" {
                discount = "0"
            }
            let productDescription = productDescriptionText.text
            let category = categoryButton.title(for: .normal)
            viewModel.addNewProduct(data: data, name: productName!, price: productPrice!, discount: discount, description: productDescription!, category: category!, clothingSizes: clothingSizes)
            let alertview = JSSAlertView().show(self,
              title: "Added New Product!",
              buttonText: "Ok"
            )
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            helper.showAlert(title: "Please Fill All Fields Except Discount", message: "", in: self)
        }
    }
    
    func fieldsValid() -> Bool {
        if((productNameText.text != "" || productNameText.text != nil) && (productPriceText.text != "" || productPriceText.text != nil) && (productDescriptionText.text != "" || productDescriptionText.text != nil) && imageSelected || (categoryButton.title(for: .normal) == "Clothing" && (smallBtn.isSelected == true || medBtn.isSelected == true || largeBtn.isSelected == true || xlBtn.isSelected == true || xxlBtn.isSelected == true))) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func categoryButtonClicked(_ sender: Any) {
        dataSource = ["Clothing", "Concentrate", "Edible", "Supplies"]
        selectedButton = categoryButton
        addTransparentView(frames: categoryButton.frame)
    }
    
    func checkClothingSizes() {
        if smallBtn.isSelected == true {
            clothingSizes = clothingSizes + "S;"
        }
        if medBtn.isSelected == true {
            clothingSizes = clothingSizes + "M;"
        }
        if largeBtn.isSelected == true {
            clothingSizes = clothingSizes + "L;"
        }
        if xlBtn.isSelected == true {
            clothingSizes = clothingSizes + "XL;"
        }
        if xxlBtn.isSelected == true {
            clothingSizes = clothingSizes + "XXL;"
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
    
    @IBAction func smallClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    func showPicker(with source: UIImagePickerController.SourceType) {
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        image = (info[.editedImage] as? UIImage)!
        productImage.image = image
        data = image.jpegData(compressionQuality: 0.5)!
        imageSelected = true
        dismiss(animated: true)
    }
    
    @IBAction func textEndEditing(_ sender: UITextField) {
        if ((sender.text?.range(of: "$", options: .caseInsensitive)) == nil) {
            sender.text = "$" + sender.text!
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    func initButtons() {
        smallBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-48.png"), for: .normal)
        smallBtn.setImage(UIImage(named: "icons8-checked-checkbox-48.png"), for: .selected)
        medBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-48.png"), for: .normal)
        medBtn.setImage(UIImage(named: "icons8-checked-checkbox-48.png"), for: .selected)
        largeBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-48.png"), for: .normal)
        largeBtn.setImage(UIImage(named: "icons8-checked-checkbox-48.png"), for: .selected)
        xlBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-48.png"), for: .normal)
        xlBtn.setImage(UIImage(named: "icons8-checked-checkbox-48.png"), for: .selected)
        xxlBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-48.png"), for: .normal)
        xxlBtn.setImage(UIImage(named: "icons8-checked-checkbox-48.png"), for: .selected)
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

extension AddProduct: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
        cellText = dataSource[indexPath.row]
        if cellText == "Clothing" {
            stockLabel.isHidden = false
            smallBtn.isHidden = false
            medBtn.isHidden = false
            largeBtn.isHidden = false
            xlBtn.isHidden = false
            xxlBtn.isHidden = false
            sLabel.isHidden = false
            mLabel.isHidden = false
            lLabel.isHidden = false
            xlLabel.isHidden = false
            xxlLabel.isHidden = false
        } else {
            stockLabel.isHidden = true
            smallBtn.isHidden = true
            medBtn.isHidden = true
            largeBtn.isHidden = true
            xlBtn.isHidden = true
            xxlBtn.isHidden = true
            sLabel.isHidden = true
            mLabel.isHidden = true
            lLabel.isHidden = true
            xlLabel.isHidden = true
            xxlLabel.isHidden = true
        }
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
