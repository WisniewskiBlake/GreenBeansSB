//
//  AddressCell.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit

class AddressCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    
    var address: String? {
        didSet { addressLabel.text = address ?? "" }
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
