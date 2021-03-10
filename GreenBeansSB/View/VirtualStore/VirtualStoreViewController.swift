//
//  VirtualStoreViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class VirtualStoreViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var merchButton: UIButton!
    @IBOutlet weak var edibleButton: UIButton!
    @IBOutlet weak var concentrateButton: UIButton!
    @IBOutlet weak var suppliesButton: UIButton!
    
    private var category = ""
    var isMenuClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productListViewController = segue.destination as? ProductListViewController {
            if let button = sender as? UIButton {
                productListViewController.category = String(button.tag)
                productListViewController.modalPresentationStyle = .fullScreen
            }
        }
    }
}
