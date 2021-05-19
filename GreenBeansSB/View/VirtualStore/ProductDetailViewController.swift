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
    var product = Product()
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
        productTitleLabel.text = product.productTitle
        productDescriptionText.text = product.productDescription        
        
        if product.productHighlighted == "true" {
            if ((product.productDiscount.range(of: "$", options: .caseInsensitive)) == nil) {
                productDiscountLabel.text = "$" + product.productDiscount
            } else {
                productDiscountLabel.text = product.productDiscount
            }
            if ((product.productPrice.range(of: "$", options: .caseInsensitive)) == nil) {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$" + product.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPriceLabel.attributedText = attributeString
            } else {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPriceLabel.attributedText = attributeString
            }
        } else {
            productDiscountLabel.text = ""
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product.productPrice)
            productPriceLabel.attributedText = attributeString
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
    
    @IBAction func checkBoxClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    func checkButtons() {
        if product.clothingSizes != "" {
            productSizes = (product.clothingSizes.components(separatedBy: ";"))
            stockLabel.isHidden = false
            if productSizes.contains("S") {
                sLabel.isHidden = false
                smallBtn.isHidden = false                
            }
            if productSizes.contains("M") {
                mLabel.isHidden = false
                medBtn.isHidden = false
            }
            if productSizes.contains("L") {
                lLabel.isHidden = false
                largeBtn.isHidden = false
            }
            if productSizes.contains("XL") {
                xlLabel.isHidden = false
                xlBtn.isHidden = false
            }
            if productSizes.contains("XXL") {
                xxlLabel.isHidden = false
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
extension ProductDetailViewController {
    func isValidQuantity(quantity: String) {
        if(productQuantityLabel.text != "0") {
            let alertview = JSSAlertView().show(self,
              title: "Added To Cart",
              buttonText: "Ok"
            )
            viewModel?.addProductToCart(product: product, quantity: productQuantityLabel.text ?? "0")
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
        } else {
            helper.showAlert(title: "Please Select Quantity", message: "", in: self)
        }
    }    
}

