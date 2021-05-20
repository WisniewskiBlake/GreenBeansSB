//
//  ProductDetailViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/14/1399 AP.
//

import UIKit
import JSSAlertView

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var productDiscountLabel: UILabel!    
    
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
    
    let helper = Helper()
    var product: Product?
    var image: UIImage?
    var clothingSizes = ""
    var productSizes: [String] = []
    var viewModel: VirtualStoreViewModel!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initButtons()
        checkButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI() {
        productTitleLabel.text = product?.productTitle
        productTitleLabel.sizeToFit()
        productDescriptionText.text = product?.productDescription
        productImageView.image = image
        if product?.productHighlighted == "true" {
            if ((product?.productDiscount.range(of: "$", options: .caseInsensitive)) == nil) {
                productDiscountLabel.text = "$" + product!.productDiscount
            } else {
                productDiscountLabel.text = product?.productDiscount
            }
            if ((product?.productPrice.range(of: "$", options: .caseInsensitive)) == nil) {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$" + product!.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPriceLabel.attributedText = attributeString
            } else {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product!.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPriceLabel.attributedText = attributeString
            }
        } else {
            productDiscountLabel.isHidden = true
            if ((product?.productPrice.range(of: "$", options: .caseInsensitive)) == nil) {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$" + product!.productPrice)
                productPriceLabel.attributedText = attributeString
            } else {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product!.productPrice)
                productPriceLabel.attributedText = attributeString
            }            
        }
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        var quantity = Int(productQuantityLabel.text!)
        if (quantity! > 0) {
            quantity = quantity! - 1
            productQuantityLabel.text = String(quantity!)
        }
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        var quantity = Int(productQuantityLabel.text!)
        quantity = quantity! + 1
        productQuantityLabel.text = String(quantity!)
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        isValidQuantity(quantity: productQuantityLabel.text ?? "0")        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func smallBtnClicked(_ sender: UIButton) {
        smallBtn.isSelected = true
        medBtn.isSelected = false
        largeBtn.isSelected = false
        xlBtn.isSelected = false
        xxlBtn.isSelected = false
    }
    
    @IBAction func medBtnClicked(_ sender: UIButton) {
        smallBtn.isSelected = false
        medBtn.isSelected = true
        largeBtn.isSelected = false
        xlBtn.isSelected = false
        xxlBtn.isSelected = false
    }
    
    @IBAction func lBtnClicked(_ sender: UIButton) {
        smallBtn.isSelected = false
        medBtn.isSelected = false
        largeBtn.isSelected = true
        xlBtn.isSelected = false
        xxlBtn.isSelected = false
    }
    
    @IBAction func xlBtnClicked(_ sender: UIButton) {
        smallBtn.isSelected = false
        medBtn.isSelected = false
        largeBtn.isSelected = false
        xlBtn.isSelected = true
        xxlBtn.isSelected = false
    }
    
    @IBAction func xxlBtnClicked(_ sender: UIButton) {
        smallBtn.isSelected = false
        medBtn.isSelected = false
        largeBtn.isSelected = false
        xlBtn.isSelected = false
        xxlBtn.isSelected = true
    }
    
    func checkButtons() {
        if product?.clothingSizes != "" {
            productSizes = (product?.clothingSizes.components(separatedBy: ";"))!
            stockLabel.isHidden = false
            sLabel.isHidden = false
            mLabel.isHidden = false
            lLabel.isHidden = false
            xlLabel.isHidden = false
            xxlLabel.isHidden = false
            if productSizes.contains("S") {
                smallBtn.isHidden = false                
            }
            if productSizes.contains("M") {
                medBtn.isHidden = false
            }
            if productSizes.contains("L") {
                largeBtn.isHidden = false
            }
            if productSizes.contains("XL") {
                xlBtn.isHidden = false
            }
            if productSizes.contains("XXL") {
                xxlBtn.isHidden = false
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
extension ProductDetailViewController {
    func isValidQuantity(quantity: String) {
        if productDiscountLabel.isHidden == false {
            product?.productDictionary[kPRODUCTPRICE] = productDiscountLabel.text!
        } else {
            product?.productDictionary[kPRODUCTPRICE] = productPriceLabel.text!
        }
        
        if product?.productType == "Clothing" {
            if smallBtn.isSelected || medBtn.isSelected || largeBtn.isSelected || xlBtn.isSelected || xxlBtn.isSelected {
                if productQuantityLabel.text != "0" {
                    let alertview = JSSAlertView().show(self,
                      title: "Added To Cart",
                      buttonText: "Ok"
                    )
                    checkClothingSizes()
                    viewModel?.addProductToCart(product: product!, quantity: productQuantityLabel.text ?? "0", clothingSizes: clothingSizes)
                    alertview.addAction { self.dismissController() }
                    alertview.setTitleFont("ClearSans-Bold") // Title font
                    alertview.setTextFont("ClearSans") // Alert body text font
                    alertview.setButtonFont("ClearSans-Light") // Button text font
                } else {
                    helper.showAlert(title: "Please Select Quantity", message: "", in: self)
                }
            } else {
                helper.showAlert(title: "Please Select Size And Quantity", message: "", in: self)
            }
            
        } else if productQuantityLabel.text != "0" {            
            let alertview = JSSAlertView().show(self,
              title: "Added To Cart",
              buttonText: "Ok"
            )
            viewModel?.addProductToCart(product: product!, quantity: productQuantityLabel.text ?? "0", clothingSizes: clothingSizes)
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            helper.showAlert(title: "Please Select Quantity", message: "", in: self)
        }
    }    
}

