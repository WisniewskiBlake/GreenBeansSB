//
//  VirtualStoreViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit
import LGButton

class VirtualStoreViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allButton: LGButton!
    @IBOutlet weak var onSaleButton: LGButton!
    
    var dataSource = ProductListDataSource()
    var viewModel = VirtualStoreViewModel()
    private var products: [Product] = []
    private var tag = ""
    var isMenuClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedProducts"), object: nil)
        allButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        viewModel.fetchAllProducts(category: "All Products")
    }
    
    @objc func setDataSource() {
        products = viewModel.getProducts()
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    @IBAction func allClicked(_ sender: Any) {
        viewModel.fetchAllProducts(category: "All Products")
    }
    
    @IBAction func onSaleClicked(_ sender: Any) {
        viewModel.fetchAllProducts(category: "On Sale")
        onSaleButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Any", let productListViewController = segue.destination as? ProductListViewController {            
            productListViewController.category = tag
            productListViewController.modalPresentationStyle = .fullScreen
            
        }
        
        
        
//        if let productListViewController = segue.destination as? ProductListViewController {
//            if let button = sender as? UIView {
//                productListViewController.category = String(button.tag)
//                productListViewController.modalPresentationStyle = .fullScreen
//            }
//        }
    }
}
