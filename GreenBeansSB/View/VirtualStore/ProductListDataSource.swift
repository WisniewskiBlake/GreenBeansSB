//
//  VirtualStoreDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit
import Firebase

class ProductListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var products: [Product] = []
    var imageDictionary: [String:UIImage] = [:]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 184 // Give estimated Height Fo rRow here
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cellClicked"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        let image = imageDictionary[product.productTitle]
        cell.productImage = image
//        cell.productTitle = product.productTitle
        cell.productPrice = "$" + product.productPrice
        cell.productDescription = product.productTitle + " " + product.productDescription
        if product.productHighlighted == "true" {
            cell.productDiscount = product.productDiscount + " Off!"
        } else {
            cell.productDiscount = ""
        }
        
        return cell
    }    
}



