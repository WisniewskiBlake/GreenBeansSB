//
//  CustomerOrders.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/14/21.
//

import UIKit

class CustomerOrders: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = CustomerOrderCellDataSource()
    private var cartViewModel = AdminViewModel()
    private var products: [Product] = []
    
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
    

    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedOrders"), object: nil)
    }
}
