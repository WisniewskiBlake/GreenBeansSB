//
//  HistoryCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/24/21.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productStatusLabel: UILabel!
    
    var indexPath: IndexPath!
    var delegate: CartCellDelegate?
    
    func generateCell(order: Order, indexPath: IndexPath) {
        self.indexPath = indexPath
        productTitleLabel.text = String(order.products.count) + " product(s)"
        productStatusLabel.text = order.orderStatus
        
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
