//
//  OrderSummaryViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/12/21.
//

import UIKit
import JSSAlertView

class OrderSummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var instructionsTextField: UITextField!
    
    private var dataSource = CartCellDataSource()
    let helper = Helper()
    var cartViewModel: CartViewModel?    
    var order: Order?    
    var subtotal = ""
    var tax = ""
    var total = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getOrderDetails()
        configureUI()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func configureUI() {
        subtotalLabel.text = "$" + subtotal
        taxLabel.text = "$" + tax
        totalLabel.text = "$" + total
    }
    
    func getOrderDetails() {
        //self.subtotal = cartViewModel?.calculateSubtotal(productList: order!.products)
        // self.tax = cartViewModel?.calculateTax(subtotal: subtotal!)
        // self.total = cartViewModel?.calculateTotal(subtotal: subtotal!, tax: tax!)
        order?.subtotal = subtotal
        order?.tax = tax
        order?.total = total
        order?.deliveryFee = order!.deliveryFee
        cartViewModel?.fetchOrderProducts(order: order!) { (productsReturned) in
            self.dataSource.products = productsReturned
        }
    }
    
    @IBAction func placeOrderClicked(_ sender: Any) {
        if instructionsTextField.text != "" {
            order?.specialInstructions = instructionsTextField.text!
        }
        let alertview = JSSAlertView().show(self,
          title: "Order Has Been Placed",
          buttonText: "Ok"
        )
        cartViewModel?.placeOrder(order: order)
        alertview.addAction { self.helper.instantiateViewController(identifier: "VirtualStore", animated: true, by: self, completion: nil) }
        alertview.setTitleFont("ClearSans-Bold") // Title font
        alertview.setTextFont("ClearSans") // Alert body text font
        alertview.setButtonFont("ClearSans-Light") // Button text font
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
