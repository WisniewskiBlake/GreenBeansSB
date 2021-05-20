//
//  OrderDetails.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/14/21.
//

import UIKit

class OrderDetails: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var pickupDeliverTimeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var order: Order?
    var viewModel: AdminViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
