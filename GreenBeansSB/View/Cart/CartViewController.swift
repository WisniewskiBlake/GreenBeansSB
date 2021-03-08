//
//  CartViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = CartCellDataSource()    
    private var viewModel = CartViewModel()
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedCart"), object: nil)
        viewModel.fetchUserCart()
        // Do any additional setup after loading the view.
    }
    
    @objc func setDataSource() {
        products = viewModel.getCart()
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? GuestAddressViewController {
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }
}
