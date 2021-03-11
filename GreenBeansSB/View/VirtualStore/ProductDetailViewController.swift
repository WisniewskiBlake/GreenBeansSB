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
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
        
    let helper = Helper()
    var product = Product()
    var viewModel: VirtualStoreViewModel!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI() {
        productTitleLabel.text = product.productTitle
        productPriceLabel.text = product.productPrice
        productDescriptionLabel.text = product.productDescription
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
extension ProductDetailViewController {
    func isValidQuantity(quantity: String) {
        let alertview = JSSAlertView().show(self,
          title: "Added To Cart",
          buttonText: "Ok"
        )
        if(productQuantityLabel.text != "0") {
            viewModel?.addProductToCart(product: product, quantity: productQuantityLabel.text ?? "0")
            alertview.addAction { self.dismissController() }
            alertview.setTitleFont("ClearSans-Bold") // Title font
            alertview.setTextFont("ClearSans") // Alert body text font
            alertview.setButtonFont("ClearSans-Light") // Button text font
            alertview.setTextTheme(.light)            
        } else {
            helper.showAlert(title: "Please Select Quantity", message: "", in: self)
        }
    }    
}

