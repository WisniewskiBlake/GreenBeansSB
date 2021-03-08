//
//  AddressCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit

class AddressCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var addresses: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressCell
        let address = addresses[indexPath.row]
        cell.address = address       
        return cell
    }
}

