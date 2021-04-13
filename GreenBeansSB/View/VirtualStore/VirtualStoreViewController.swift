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
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var merchButton: UIButton!
    @IBOutlet weak var edibleButton: UIButton!
    @IBOutlet weak var concentrateButton: UIButton!
    @IBOutlet weak var suppliesButton: UIButton!
    @IBOutlet weak var discountedButton: UIButton!
    
    private var tag = ""
    var isMenuClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func allClicked(_ sender: Any) {
        self.tag = String((sender as AnyObject).tag)
        performSegue(withIdentifier: "Any", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Any", let productListViewController = segue.destination as? ProductListViewController {            
            productListViewController.category = tag
            productListViewController.modalPresentationStyle = .fullScreen
            
        }
        
        
        
//        if let productListViewController = segue.destination as? ProductListViewController {
//            if let button = sender as? UIView {
//                productListViewController.category = String(button.tag)
//                productListViewController.modalPresentationStyle = .fullScreen
//            }
//        }
    }
}
