//
//  OrderHistoryViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!    
    
    private var dataSource = HistoryCellDataSource()
    private var orderViewModel = OrderHistoryViewModel()
    private var products: [Product] = []
    private var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedHistory"), object: nil)
    }
    
    @objc func setDataSource() {
        orders = orderViewModel.getOrders()
        dataSource.orders = orders
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
