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
    //@IBOutlet private weak var productDescriptionText: UITextView!
    @IBOutlet weak var productDescriptionText: UILabel!
    
    var delegate: ProductCellDelegate?
    var indexPath: IndexPath!
    
    func generateCell(product: Product, image: UIImage, indexPath: IndexPath) {
        self.indexPath = indexPath
        productImage = image
        
        let attrs = [NSAttributedString.Key.font : UIFont.init(name: "Futura Bold", size: 15)]
        let attributedString = NSMutableAttributedString(string:product.productTitle + " ", attributes:attrs as [NSAttributedString.Key : Any])
        let normalString = NSMutableAttributedString(string:product.productDescription)
        attributedString.append(normalString)
        productDescription = attributedString
        
        if product.productHighlighted == "true" {
            if ((product.productDiscount.range(of: "$", options: .caseInsensitive)) == nil) {
                productDiscount = "$" + product.productDiscount
            } else {
                productDiscount = product.productDiscount
            }
            if ((product.productPrice.range(of: "$", options: .caseInsensitive)) == nil) {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$" + product.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPrice = attributeString
            } else {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product.productPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                productPrice = attributeString
            }
        } else {
            productDiscount = ""
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: product.productPrice)
            productPrice = attributeString
        }
        
        
    }
    
    var productPrice: NSMutableAttributedString? {
        didSet { productPriceLabel.attributedText = productPrice }
    }
    
    var productImage: UIImage? {
        didSet { productImageView.image = productImage }
    }
        
    var productDescription: NSMutableAttributedString? {
        didSet { productDescriptionText.attributedText = productDescription }
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
