//
//  ProductCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit

protocol ProductCellDelegate {
    func removeProduct(indexPath: IndexPath)
}

class ProductCell: UITableViewCell {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productPriceLabel: UILabel!    
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productDescriptionText: UITextView!
    
    var delegate: ProductCellDelegate?
    var indexPath: IndexPath!
    
    func generateCell(product: Product, image: UIImage, indexPath: IndexPath) {
        self.indexPath = indexPath
        productImage = image
        if ((product.productPrice.range(of: "$", options: .caseInsensitive)) == nil) {
            productPrice = "$" + product.productPrice
        } else {
            productPrice = product.productPrice
        }
        productDescription = product.productTitle + " " + product.productDescription
        if product.productHighlighted == "true" {
            productDiscount = product.productDiscount + " Off!"
        } else {
            productDiscount = ""
        }
    }
    
    var productPrice: String? {
        didSet { productPriceLabel.text = productPrice ?? "" }
    }
    
    var productImage: UIImage? {
        didSet { productImageView.image = productImage }
    }
        
    var productDescription: String? {
        didSet { productDescriptionText.text = productDescription ?? "" }
    }
    
    var productDiscount: String? {
        didSet { productDiscountLabel.text = productDiscount ?? "" }
    }
    
    @IBAction func removeClicked(_ sender: Any) {
        delegate!.removeProduct(indexPath: indexPath)
    }    

    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
