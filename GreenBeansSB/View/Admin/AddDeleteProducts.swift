//
//  AddDeleteProducts.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/2/21.
//

import UIKit

class AddDeleteProducts: UIViewController {
    let viewModel = VirtualStoreViewModel()
    var dataSource = ProductListDataSource()
    private var products: [Product] = []
    private var imageDictionary: [String:UIImage] = [:]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadImages), name: NSNotification.Name(rawValue: "loadedProducts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedImages"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellClicked), name: NSNotification.Name(rawValue: "cellClicked"), object: nil)
        viewModel.fetchAllProducts(category: "All Products")
    }  
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let helper = Helper()
        helper.instantiateViewController(identifier: "AddProducts", animated: true, by: self, completion: nil)
        //performSegue(withIdentifier: "AddProduct", sender: self)
    }
    
    @objc func loadImages() {
        products = viewModel.getProducts()
        viewModel.loadImages(products: products)
    }
    
    @objc func setDataSource() {
        imageDictionary = viewModel.getImages()
        dataSource.products = products
        dataSource.imageDictionary = imageDictionary
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
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
