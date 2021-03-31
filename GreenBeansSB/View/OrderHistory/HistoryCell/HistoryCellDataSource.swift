//
//  HistoryCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/24/21.
//

import UIKit

class HistoryCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var orders: [Order] = []    
    var viewModel: OrderHistoryViewModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell        
        cell.generateCell(order: order, indexPath: indexPath)
        
        return cell
    }

}
