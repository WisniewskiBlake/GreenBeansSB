//
//  CartCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import UIKit

class CartCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CartCellDelegate {
    var products: [Product] = []
    var viewModel: CartViewModel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        cell.delegate = self
        cell.generateCell(product: product, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            products.remove(at: indexPath.row)
            viewModel?.removeProductFromCart(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func removeProductFromCart(indexPath: IndexPath) {
        products.remove(at: indexPath.row)
        viewModel?.removeProductFromCart(indexPath: indexPath)
    }
}
