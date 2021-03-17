//
//  PickupViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/17/21.
//

import UIKit

class PickupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = AddressCellDataSource()
    var order: Order?
    var cartViewModel: CartViewModel?
    
    private var addresses: [String] = ["101 South Mason Rd. - Saginaw, MI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(navigate), name: NSNotification.Name(rawValue: "cellClicked"), object: nil)
        dataSource.addresses = addresses
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func navigate() {
        if cartViewModel?.userInSession() == true {
            performSegue(withIdentifier: "ToOrderSummary", sender: self)
        } else {
            performSegue(withIdentifier: "ToGuestAddress", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            order?.pickUpAddress = dataSource.addresses[row]
            if segue.identifier == "ToOrderSummary", let orderSummaryVC = segue.destination as? OrderSummaryViewController {
                orderSummaryVC.cartViewModel = cartViewModel
                orderSummaryVC.order = order
                orderSummaryVC.modalPresentationStyle = .fullScreen
            }
            if segue.identifier == "ToGuestAddress", let guestAddressVC = segue.destination as? GuestAddressViewController {
                guestAddressVC.cartViewModel = cartViewModel
                guestAddressVC.order = order
                guestAddressVC.pickUp = true
                guestAddressVC.modalPresentationStyle = .fullScreen
            }
        }        
    }
}
