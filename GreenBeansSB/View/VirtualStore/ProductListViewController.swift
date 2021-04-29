//
//  ProductListViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/13/1399 AP.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var category: String = ""    
    var dataSource = ProductListDataSource()    
    var viewModel = VirtualStoreViewModel()
    private var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedProducts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellClicked), name: NSNotification.Name(rawValue: "cellClicked"), object: nil)
        self.getCategoryTitle(tag: category)
        viewModel.fetchAllProducts(category: categoryTitleLabel.text!)
    }
    
    @objc func setDataSource() {
        products = viewModel.getProducts()
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func cellClicked() {
        products = viewModel.getProducts()
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension ProductListViewController {
    func getCategoryTitle(tag: String) {
        switch Int(tag) {
        case 1:
            categoryTitleLabel.text = "All Products"
        case 2:
            categoryTitleLabel.text = "Merchandise"
        case 3:
            categoryTitleLabel.text = "Edibles"
        case 4:
            categoryTitleLabel.text = "Concentrate"
        case 5:
            categoryTitleLabel.text = "Supplies"
        case 6:
            categoryTitleLabel.text = "On Sale"
        default:
            categoryTitleLabel.text = "None"
        }
    }
}
