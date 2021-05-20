//
//  CartCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import UIKit
import LGButton

protocol CartCellDelegate {
    func removeProductFromCart(indexPath: IndexPath)
    func increaseQuantity(indexPath: IndexPath)
    func decreaseQuantity(indexPath: IndexPath)
}

class CartCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCostTotalLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var plusBtn: LGButton!
    @IBOutlet weak var minusBtn: LGButton!
    
    
    
    
    var indexPath: IndexPath!
    var delegate: CartCellDelegate?
    
    func generateCell(product: Product, image: UIImage, indexPath: IndexPath) {
        self.indexPath = indexPath
        productTitleLabel.text = product.productTitle
        productQuantityLabel.text = product.productQuantity
        productImageView.image = image
        if ((product.productPrice.range(of: "$", options: .caseInsensitive)) != nil) {
            //productPriceLabel.text = product.productPrice
            let doublePrice = product.productPrice.replacingOccurrences(of: "$", with: "")
            productCostTotalLabel.text = "$" + String(Double(doublePrice)! * Double(product.productQuantity + ".0")!)
        } else {
            productPriceLabel.text = "$" + product.productPrice
            productCostTotalLabel.text = "$" + String(Double(product.productPrice)! * Double(product.productQuantity + ".0")!)
        }
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        delegate!.increaseQuantity(indexPath: indexPath)
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        delegate!.decreaseQuantity(indexPath: indexPath)
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

