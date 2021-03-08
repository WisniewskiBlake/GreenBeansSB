//
//  VirtualStoreDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit

class ProductListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var products: [Product] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.productTitle = product.productTitle
        cell.productPrice = product.productPrice
        cell.productDescription = product.productDescription
        return cell
    }    
}



