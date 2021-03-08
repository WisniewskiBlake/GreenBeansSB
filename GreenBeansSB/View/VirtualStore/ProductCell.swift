//
//  ProductCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit

protocol ProductCellDelegate {
    func didTapProductCell(indexPath: IndexPath)
}

class ProductCell: UITableViewCell {
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    
    var delegate: ProductCellDelegate?
        
    var productTitle: String? {
        didSet { productTitleLabel.text = productTitle ?? "" }
    }
    
    var productPrice: String? {
            didSet { productPriceLabel.text = productPrice ?? "" }
    }
        
    var productDescription: String? {
        didSet { productDescriptionLabel.text = productDescription ?? "" }
    }

    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
