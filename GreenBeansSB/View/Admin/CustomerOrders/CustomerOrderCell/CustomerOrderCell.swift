//
//  CustomerOrderCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/16/21.
//

import UIKit

protocol CustomerOrderCellDelegate {
    func archiveOrder(indexPath: IndexPath)
}

class CustomerOrderCell: UITableViewCell {
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var archiveButton: UIButton!
    
    var indexPath: IndexPath!
    var delegate: CustomerOrderCellDelegate?
    
    func generateCell(order: Order, indexPath: IndexPath) {
        self.indexPath = indexPath
        orderNumberLabel.text = order.orderId
        orderStatusLabel.text = order.orderStatus
    }
    
    @IBAction func archiveButtonClicked(_ sender: Any) {
        delegate!.archiveOrder(indexPath: indexPath)
    }
    
}
