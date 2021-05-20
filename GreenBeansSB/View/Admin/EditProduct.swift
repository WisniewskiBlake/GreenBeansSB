//
//  EditProduct.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/3/21.
//

import UIKit
import JSSAlertView

class EditProduct: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var productNameText: UITextField!
    @IBOutlet weak var productPriceText: UITextField!
    @IBOutlet weak var productDiscount: UITextField!    
    @IBOutlet weak var productDescriptionTextView: UITextView!
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
    
    var data = Data()
    let helper = Helper()
    var product: Product?
    var image: UIImage?
    let viewModel = VirtualStoreViewModel.sharedViewModel
    var imageSelected: Bool = false
    var productSizes: [String] = []
    let imagePickerVC = UIImagePickerController()
    let imageTapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initUI()
        initButtons()
        checkButtons()
        imageTapGestureRecognizer.addTarget(self, action: #selector(self.handleImageTap))
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        if fieldsValid() {
            checkClothingSizes()
            let productName = productNameText.text
            let productPrice = productPriceText.text
            var discount = productDiscount.text ?? "0"
            if discount == "$0" {
                discount = "0"
            }
            let productDescription = productDescriptionTextView.text
            let category = categoryButton.title(for: .normal)
            viewModel.editProduct(data: data, name: productName!, price: productPrice!, discount: discount, description: productDescription!, category: category!, clothingSizes: clothingSizes, imageChanged: imageSelected, product: product!)
            let alertview = JSSAlertView().show(self,
              title: "Product Updated!",
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
        if categoryButton.title(for: .normal) == "Clothing" {
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
    
    func checkButtons() {
        if product?.clothingSizes != nil || product?.clothingSizes != "" {
            productSizes = (product?.clothingSizes.components(separatedBy: ";"))!
            if productSizes.contains("S") {
                smallBtn.isSelected.toggle()
            }
            if productSizes.contains("M") {
                medBtn.isSelected.toggle()
            }
            if productSizes.contains("L") {
                largeBtn.isSelected.toggle()
            }
            if productSizes.contains("XL") {
                xlBtn.isSelected.toggle()
            }
            if productSizes.contains("XXL") {
                xxlBtn.isSelected.toggle()
            }
        }
    }
    
    func initUI() {
        productNameText.delegate = self
        productPriceText.delegate = self
        productDiscount.delegate = self
        productDescriptionTextView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        productNameText.text = product?.productTitle
        productPriceText.text = product?.productPrice
        productImage.image = image
        productDiscount.text = product?.productDiscount
        productDescriptionTextView.text = product?.productDescription
        categoryButton.setTitle(product?.productType, for: .normal)
        productImage.isUserInteractionEnabled = true
        productImage.addGestureRecognizer(imageTapGestureRecognizer)
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func fieldsValid() -> Bool {
        if((productNameText.text != "" || productNameText.text != nil) && (productPriceText.text != "" || productPriceText.text != nil) && (productDescriptionTextView.text != "" || productDescriptionTextView.text != nil) && imageSelected || (categoryButton.title(for: .normal) == "Clothing" && (smallBtn.isSelected == true || medBtn.isSelected == true || largeBtn.isSelected == true || xlBtn.isSelected == true || xxlBtn.isSelected == true))) {
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
        data = image!.jpegData(compressionQuality: 0.5)!
        imageSelected = true
        dismiss(animated: true)
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
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textEndEditing(_ sender: UITextField) {
        if ((sender.text?.range(of: "$", options: .caseInsensitive)) == nil) {
            sender.text = "$" + sender.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
         return true
    }
    
    func textViewShouldReturn(_ textField: UITextView) -> Bool {
        self.view.endEditing(true)
         return true
    }    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // return NO to not change text
        if textField == productPriceText || textField == productDiscount {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                return true
            case ".":
                let array = Array(arrayLiteral: textField.text)
                var decimalCount = 0
                for character in array {
                    if character == "." {
                        decimalCount += 1
                    }
                }
                if decimalCount == 1 {
                    return false
                } else {
                    return true
                }
            default:
                let array = Array(string)
                if array.count == 0 {
                    return true
                }
                return false
            }
        } else {
            return true
        }
    }
}

extension EditProduct : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension EditProduct: UITableViewDelegate, UITableViewDataSource {
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
