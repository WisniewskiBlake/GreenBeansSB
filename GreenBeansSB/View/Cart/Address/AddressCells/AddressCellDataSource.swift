//
//  AddressCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit

class AddressCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var addresses: [String] = []
    var viewModel: AddressViewModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
        let address = addresses[indexPath.row]
        cell.address = address       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addressCellClicked"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {            
            viewModel?.removeUserAddress(address: addresses[indexPath.row], indexPath: indexPath)
            addresses.remove(at: indexPath.row)            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

