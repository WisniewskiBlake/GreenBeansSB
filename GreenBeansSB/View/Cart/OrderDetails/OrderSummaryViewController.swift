//
//  OrderSummaryViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/12/21.
//

import UIKit
import JSSAlertView

class OrderSummaryViewController: UIViewController, UITextFieldDelegate {
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
        instructionsTextField.delegate = self
        getOrderDetails()
        configureUI()        
    }
    
    func configureUI() {
        if order?.orderType == "Delivery" {
            deliveryLabel.text = "$" + order!.deliveryFee
        } else {
            deliveryLabel.text = "N/A"
        }
        subtotalLabel.text = "$" + subtotal
        taxLabel.text = "$" + tax
        totalLabel.text = "$" + total
    }
    
    func getOrderDetails() {
        self.subtotal = (cartViewModel?.calculateSubtotal(productList: cartViewModel?.getCart() ?? []))!
        self.tax = (cartViewModel?.calculateTax(subtotal: subtotal))!
        self.total = (cartViewModel?.calculateTotal(subtotal: subtotal, tax: tax, order: order!))!
        order?.subtotal = subtotal
        order?.tax = tax
        order?.total = total

        self.dataSource.products = (cartViewModel?.getCart())!
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
         return true
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }

}
