//
//  AddDeleteProducts.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/2/21.
//

import UIKit

class AddDeleteProducts: UIViewController {
    let viewModel = VirtualStoreViewModel()
    let adminViewModel = AdminViewModel()
    var dataSource = ProductListDataSource.sharedProductDS
    
    private var products: [Product] = []
    private var imageDictionary: [String:UIImage] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(loadImages), name: NSNotification.Name(rawValue: "loadedAdminProducts"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedAdminImages"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellClicked), name: NSNotification.Name(rawValue: "cellAdminClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "adminRemove"), object: nil)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
        //viewModel.fetchAllProducts(category: "All Products", vc: "Admin")
    }  
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let helper = Helper()
        helper.instantiateViewController(identifier: "AddProducts", animated: true, by: self, completion: nil)
        //performSegue(withIdentifier: "AddProduct", sender: self)
    }
    
//    @objc func loadImages() {
//        if  !products.isEmpty && !imageDictionary.isEmpty {            
//            tableView.dataSource = dataSource
//            tableView.delegate = dataSource
//            tableView.reloadData()
//        } else {
//            products = viewModel.getProducts()
//            viewModel.loadImages(products: products, vc: "Admin")
//        }
//        
//    }
//    
//    @objc func setDataSource() {
//        tableView.dataSource = dataSource
//        tableView.delegate = dataSource
//        tableView.reloadData()
//    }
    
    @objc func updateUI() {
        products = dataSource.products
        tableView.reloadData()
    }
    
    @objc func cellClicked() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productDetailVC") as? ProductDetailViewController
        {
            if let row = tableView.indexPathForSelectedRow?.row {
                let product = dataSource.products[row]
            vc.product = product
            vc.viewModel = viewModel
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
}
