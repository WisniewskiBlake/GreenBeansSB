//
//  CartViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = CartCellDataSource()
    private var viewModel = CartViewModel()
    private var products: [Product] = []
    private var order: Order?
    private let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotifications()
        viewModel.fetchUserCart()
        order?.products = products
    }
    
    @objc func setDataSource() {
        products = viewModel.getCart()
        dataSource.viewModel = viewModel
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func updateTableView() {
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
        if let destinationViewController = segue.destination as? OrderTypeViewController {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            destinationViewController.products = products
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }    
    
    func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: NSNotification.Name(rawValue: "productRemoved"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedCart"), object: nil)
    }
}
