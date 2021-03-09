//
//  OrderTypeViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/8/21.
//

import UIKit

class OrderTypeViewController: UIViewController {
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    
    private let helper = Helper()
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickUpButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func deliveryButtonClicked(_ sender: Any) {
        
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
