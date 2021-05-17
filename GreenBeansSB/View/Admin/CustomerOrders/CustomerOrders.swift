//
//  CustomerOrders.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/14/21.
//

import UIKit

class CustomerOrders: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    private var dataSource = CustomerOrderCellDataSource()
    private var viewModel = AdminViewModel()
    private var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenter()
        filterSegmentedControl.selectedSegmentIndex = 0
        viewModel.fetchCustomerOrders(filter: "PLACED")
    }
    
    @objc func setDataSource() {
        orders = viewModel.getOrders()
        dataSource.viewModel = viewModel
        dataSource.orders = orders
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.fetchCustomerOrders(filter: "PLACED")
        case 1:
            viewModel.fetchCustomerOrders(filter: "PROCESSING")
        case 2:
            viewModel.fetchCustomerOrders(filter: "COMPLETED")
        case 3:
            viewModel.fetchCustomerOrders(filter: "ARCHIVED")
        default:
            return
        }
    }
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedOrders"), object: nil)
    }
}
