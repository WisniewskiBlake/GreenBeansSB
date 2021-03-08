//
//  CartCellDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/17/1399 AP.
//

import UIKit

class CartCellDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var products: [Product] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        let product = products[indexPath.row]
        cell.productTitle = product.productTitle
        cell.productPrice = product.productPrice
        cell.productQuantity = product.productQuantity
        cell.productCostTotal = Double(product.productPrice)! * Double(product.productQuantity + ".0")!
        return cell
    }    
}
