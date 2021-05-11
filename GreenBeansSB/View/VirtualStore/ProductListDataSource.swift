//
//  VirtualStoreDataSource.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit
import Firebase

class ProductListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, ProductCellDelegate {
    static let sharedProductDS = ProductListDataSource()
    var products: [Product] = []
    var imageDictionary: [String:UIImage] = [:]
    var viewModel: VirtualStoreViewModel?
    
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cellStoreClicked"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cellAdminClicked"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        let image = imageDictionary[product.productTitle]!
        cell.delegate = self
        cell.generateCell(product: product, image: image, indexPath: indexPath)
        return cell
    }
    
    func removeProduct(indexPath: IndexPath) {
        let product = products[indexPath.row]
        products.remove(at: indexPath.row)
        imageDictionary.removeValue(forKey: product.productTitle)
        viewModel?.removeProduct(indexPath: indexPath, product: product)
    }
}



