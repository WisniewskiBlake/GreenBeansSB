//
//  CartCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import UIKit

protocol CartCellDelegate {
    func removeProductFromCart(indexPath: IndexPath)
}

class CartCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCostTotalLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var indexPath: IndexPath!
    var delegate: CartCellDelegate?
    
    func generateCell(product: Product, indexPath: IndexPath) {
        self.indexPath = indexPath
        productTitleLabel.text = product.productTitle
        productPriceLabel.text = "$" + product.productPrice
        productQuantityLabel.text = "x" + product.productQuantity
        productCostTotalLabel.text = "$" + String(Double(product.productPrice)! * Double(product.productQuantity + ".0")!)
    }
    
    @IBAction func removeButtonClicked(_ sender: Any) {
        delegate!.removeProductFromCart(indexPath: indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}









//     var productTitle: String? {
//        didSet { productTitleLabel.text = productTitle ?? "" }
//    }
//
//    var productPrice: String? {
//            didSet { productPriceLabel.text = productPrice ?? "" }
//    }
//
//    var productQuantity: String? {
//        didSet { productQuantityLabel.text = "x" + (productQuantity ?? "") }
//    }
//
//    var productCostTotal: Double? {
//        didSet {
//            let total = String(productCostTotal ?? 0)
//            productCostTotalLabel.text = total }
//    }
