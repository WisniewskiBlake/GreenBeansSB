//
//  ProductCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productPriceLabel: UILabel!    
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productDescriptionText: UITextView!
    
//    var productTitle: String? {
//        didSet { productTitleLabel.text = productTitle ?? "" }
//    }
    
    var productPrice: String? {
        didSet { productPriceLabel.text = productPrice ?? "" }
    }
    
    var productImage: UIImage? {
        didSet { productImageView.image = productImage }
    }
        
    var productDescription: String? {
//        didSet { productDescriptionLabel.text = productDescription ?? "" }
        didSet { productDescriptionText.text = productDescription ?? "" }
    }
    
    var productDiscount: String? {
        didSet { productDiscountLabel.text = productDiscount ?? "" }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
