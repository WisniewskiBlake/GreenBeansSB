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
    private var addresses: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setDataSource), name: NSNotification.Name(rawValue: "loadedAddress"), object: nil)
        viewModel.fetchUserAddress()
        // Do any additional setup after loading the view.
    }
    
    @objc func setDataSource() {
//        addresses = viewModel.getAddress()
//        dataSource.addresses = addresses
//        tableView.dataSource = dataSource
//        tableView.reloadData()
    }
    
    @IBAction func newButtonClicked(_ sender: Any) {
    }
    @IBAction func menuButtonClicked(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
