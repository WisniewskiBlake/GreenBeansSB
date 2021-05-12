//
//  AddDeleteProducts.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/2/21.
//

import UIKit

class AddDeleteProducts: UIViewController {
    let viewModel = VirtualStoreViewModel.sharedViewModel
    let adminViewModel = AdminViewModel()
    var dataSource = ProductListDataSource.sharedProductDS
    
    private var products: [Product] = []
    private var imageDictionary: [String:UIImage] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initObservers()
        updateUI()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.fetchAllProducts(category: "All Products", vc: "Store")
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let helper = Helper()
        helper.instantiateViewController(identifier: "AddProducts", animated: true, by: self, completion: nil)
    }
    
    @objc func updateUI() {
        products = viewModel.getProducts()
        imageDictionary = viewModel.getImages()
//        dataSource.products = products
//        dataSource.imageDictionary = imageDictionary
//        dataSource.viewModel = viewModel
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    @objc func cellClicked() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProduct") as? EditProduct
        {
            if let row = tableView.indexPathForSelectedRow?.row {
                let product = dataSource.products[row]
                vc.product = product
                vc.image = dataSource.imageDictionary[product.productTitle]!
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "AddProduct", let destinationViewController = segue.destination as? AddProduct {
            addTransitionRight()
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }
    
    func initObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "cellAdminClicked"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "adminRemove"), object: nil)
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "editProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellClicked), name: NSNotification.Name(rawValue: "cellAdminClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "adminRemove"), object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "editProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "loadedStoreImages"), object: nil)
    }
}
