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
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func updateUI() {
        tableView.reloadData()
    }
    
    @IBAction func newButtonClicked(_ sender: Any) {
        
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewAddress", let userAddressViewController = segue.destination as? NewAddressViewController {
            userAddressViewController.addressViewModel = viewModel
            userAddressViewController.modalPresentationStyle = .fullScreen
        } else {
            if let row = tableView.indexPathForSelectedRow?.row {
                let address = dataSource.addresses[row]
                if let productDetailVC = segue.destination as? ProductDetailViewController {
  
                    productDetailVC.modalPresentationStyle = .fullScreen
                }
            }
        }
    }
    
    func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedAddresses"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: "newAddress"), object: nil)
    }
}
