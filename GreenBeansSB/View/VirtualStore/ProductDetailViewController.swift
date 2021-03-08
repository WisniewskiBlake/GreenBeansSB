//
//  ProductDetailViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/14/1399 AP.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
        
    let helper = Helper()
    var product = Product()
    var viewModel: VirtualStoreViewModel?
            
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
        if(productQuantityLabel.text != "0") {
            viewModel?.addProductToCart(product: product, quantity: productQuantityLabel.text ?? "0")
            helper.showAlert(title: "Added To Cart", message: "", in: self)
        } else {
            helper.showAlert(title: "Please Select Quantity", message: "", in: self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
