//
//  CustomerOrderCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/16/21.
//

import UIKit

class CustomerOrderCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CustomerOrderCellDelegate {
    var orders: [Order] = []
    var viewModel: AdminViewModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerOrderCell", for: indexPath) as! CustomerOrderCell
        cell.delegate = self
        cell.generateCell(order: order, indexPath: indexPath)
        return cell
    }
    
    func archiveOrder(indexPath: IndexPath) {
//        products.remove(at: indexPath.row)
//        viewModel?.removeProductFromCart(indexPath: indexPath)
    }
}
