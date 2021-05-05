//
//  UserAddressViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import UIKit

class UserAddressViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = AddressCellDataSource()
    private var viewModel = AddressViewModel()
    var cartViewModel: CartViewModel?
    var order: Order?
    
    private var addresses: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationCenter()
        viewModel.fetchUserAddresses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func setDataSource() {
        addresses = viewModel.getAddresses()
        dataSource.addresses = addresses
        dataSource.viewModel = viewModel
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    @objc func updateUI() {
        tableView.reloadData()
    }
    
    @objc func getDeliveryFee() {
        if let row = tableView.indexPathForSelectedRow?.row {
            order?.customerAddress = dataSource.addresses[row]
            self.viewModel.getCoordinate(addressString: order!.customerAddress, completionHandler: { (coordinate, error) -> Void in
                if error == nil {
                    self.viewModel.calcDeliveryFee(endCoordinate: coordinate)
                }
            })            
        }
    }
    
    @objc func loadedFee() {
        order?.deliveryFee = viewModel.getDeliveryFee()
        performSegue(withIdentifier: "OrderSummary", sender: self)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "NewAddress", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewAddress", let newAddressViewController = segue.destination as? NewAddressViewController {
            newAddressViewController.addressViewModel = viewModel
            newAddressViewController.modalPresentationStyle = .fullScreen
        }
        if segue.identifier == "OrderSummary", let orderSummaryVC = segue.destination as? OrderSummaryViewController {
            orderSummaryVC.cartViewModel = self.cartViewModel
            orderSummaryVC.order = self.order
            orderSummaryVC.modalPresentationStyle = .fullScreen
        }
        
    }
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedAddresses"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadedFee), name: NSNotification.Name(rawValue: "calcFee"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getDeliveryFee), name: NSNotification.Name(rawValue: "addressCellClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "newAddress"), object: nil)
    }
}
