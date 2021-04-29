//
//  VirtualStoreViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit
import LGButton

class VirtualStoreViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allButton: LGButton!
    @IBOutlet weak var onSaleButton: LGButton!
    @IBOutlet weak var clothingButton: LGButton!
    @IBOutlet weak var concentrateButton: LGButton!
    @IBOutlet weak var edibleButton: LGButton!
    @IBOutlet weak var suppliesButton: LGButton!
    
    var dataSource = ProductListDataSource()
    var viewModel = VirtualStoreViewModel()
    private var products: [Product] = []
    private var tag = ""
    var isMenuClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedProducts"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cellClicked), name: NSNotification.Name(rawValue: "cellClicked"), object: nil)
//        allButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
//        allButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        viewModel.fetchAllProducts(category: "All Products")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func setDataSource() {
//        onSaleButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
//        onSaleButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        products = viewModel.getProducts()
        dataSource.products = products
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    @objc func cellClicked() {
        performSegue(withIdentifier: "Any", sender: self)
    }

    @IBAction func allClicked(_ sender: Any) {
        //allProductsPink()
        viewModel.fetchAllProducts(category: "All Products")
    }
    
    @IBAction func onSaleClicked(_ sender: Any) {
        //onSalePink()
        viewModel.fetchAllProducts(category: "On Sale")
    }
    
    @IBAction func clothingClicked(_ sender: Any) {
        //clothingPink()
        viewModel.fetchAllProducts(category: "Merchandise")
    }
    
    @IBAction func concentrateClicked(_ sender: Any) {
        //concentratePink()
        viewModel.fetchAllProducts(category: "Concentrate")
    }
    
    @IBAction func edibleClicked(_ sender: Any) {
        //ediblePink()
        viewModel.fetchAllProducts(category: "Edible")
    }
    
    @IBAction func suppliesClicked(_ sender: Any) {
        //suppliesPink()
        viewModel.fetchAllProducts(category: "Supplies")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let product = dataSource.products[row]
            if let productDetailVC = segue.destination as? ProductDetailViewController {
                productDetailVC.product = product
                productDetailVC.viewModel = viewModel
                productDetailVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Any", let productListViewController = segue.destination as? ProductListViewController {
//            productListViewController.category = tag
//            productListViewController.modalPresentationStyle = .fullScreen
//
//        }
//
//
//
////        if let productListViewController = segue.destination as? ProductListViewController {
////            if let button = sender as? UIView {
////                productListViewController.category = String(button.tag)
////                productListViewController.modalPresentationStyle = .fullScreen
////            }
////        }
//    }
    
    func allProductsPink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
    }
    
    func onSalePink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
    }
    
    func clothingPink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
    }
    
    func concentratePink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
    }
    
    func ediblePink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
    }
    
    func suppliesPink() {
        allButton.gradientStartColor = nil
        allButton.gradientEndColor = nil
        allButton.gradientHorizontal = false
        allButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        allButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        onSaleButton.gradientStartColor = nil
        onSaleButton.gradientEndColor = nil
        onSaleButton.gradientHorizontal = false
        onSaleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        onSaleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        clothingButton.gradientStartColor = nil
        clothingButton.gradientEndColor = nil
        clothingButton.gradientHorizontal = false
        clothingButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        clothingButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        concentrateButton.gradientStartColor = nil
        concentrateButton.gradientEndColor = nil
        concentrateButton.gradientHorizontal = false
        concentrateButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        concentrateButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        edibleButton.gradientStartColor = nil
        edibleButton.gradientEndColor = nil
        edibleButton.gradientHorizontal = false
        edibleButton.gradientStartColor = #colorLiteral(red: 0.2965001166, green: 0.8056601286, blue: 0.1605910063, alpha: 1)
        edibleButton.gradientEndColor = #colorLiteral(red: 0.502147913, green: 0.8779366612, blue: 0.4023095369, alpha: 1)
        suppliesButton.gradientStartColor = nil
        suppliesButton.gradientEndColor = nil
        suppliesButton.gradientHorizontal = false
        suppliesButton.gradientStartColor = #colorLiteral(red: 1, green: 0.4314318299, blue: 0.7802562118, alpha: 1)
        suppliesButton.gradientEndColor = #colorLiteral(red: 1, green: 0.5957168212, blue: 0.8018686056, alpha: 1)
    }
    
    
    
}
