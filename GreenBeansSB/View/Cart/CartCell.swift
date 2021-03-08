//
//  CartCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import UIKit

class CartCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCostTotalLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var productTitle: String? {
        didSet { productTitleLabel.text = productTitle ?? "" }
    }
    
    var productPrice: String? {
            didSet { productPriceLabel.text = productPrice ?? "" }
    }
        
    var productQuantity: String? {
        didSet { productQuantityLabel.text = "x" + (productQuantity ?? "") }
    }
    
    var productCostTotal: Double? {
        didSet {
            let total = String(productCostTotal ?? 0) 
            productCostTotalLabel.text = total }
    }    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
