//
//  CartViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    private var dataSource = CartCellDataSource()
    private var cartViewModel = CartViewModel()
    private var products: [Product] = []
    private var order = Order()
    private let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenter()        
    }
    
    @objc func setDataSource() {
        products = cartViewModel.getCart()
        hideCheckout()
        dataSource.viewModel = cartViewModel
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func updateUI() {
        products = dataSource.products                
        tableView.reloadData()
    }
    
    @IBAction func checkoutButtonClicked(_ sender: Any) {
        if(!dataSource.products.isEmpty) {
            performSegue(withIdentifier: "OrderType", sender: self)
        } else {
            helper.showAlert(title: "No Items In Cart", message: "", in: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for product in products {
            order.products.append(product.productTitle + ";" + product.productQuantity)
        }
        if let destinationViewController = segue.destination as? OrderTypeViewController {
            addTransitionRight()
            destinationViewController.order = order
            destinationViewController.cartViewModel = cartViewModel
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }
    
    func hideCheckout() {
        if products.isEmpty {
            checkoutButton.isHidden = true
        } else {
            checkoutButton.isHidden = false
        }
    }
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "productRemoved"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedCart"), object: nil)
    }
}
