//
//  OrderSummaryViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/12/21.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var instructionsTextField: UITextField!
    
    private var dataSource = CartCellDataSource()
    var cartViewModel: CartViewModel?    
    var order: Order?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func configureUI() {
        var deliveryFee = ""
        if order?.orderType != "pickUp" {
            deliveryFee = (cartViewModel?.calculateDelivery(address: order!.customerAddress))!
        }
        let subtotal = cartViewModel?.calculateSubtotal(productList: order!.products)
        let tax = cartViewModel?.calculateTax(subtotal: subtotal!)
        let total = cartViewModel?.calculateTotal(subtotal: subtotal!, tax: tax!)
        
        subtotalLabel.text = "$" + subtotal!
        taxLabel.text = "$" + tax!
        totalLabel.text = "$" + total!
        order?.subtotal = subtotal!
        order?.tax = tax!
        order?.total = total!        
        order?.deliveryFee = deliveryFee
        dataSource.products = order!.products
    }
    
    @IBAction func placeOrderClicked(_ sender: Any) {
        cartViewModel?.placeOrder(order: order)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
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
