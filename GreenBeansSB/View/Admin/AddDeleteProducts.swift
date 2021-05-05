//
//  AddDeleteProducts.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 5/2/21.
//

import UIKit

class AddDeleteProducts: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }  
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let helper = Helper()
        helper.instantiateViewController(identifier: "AddProducts", animated: true, by: self, completion: nil)
        //performSegue(withIdentifier: "AddProduct", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "AddProduct", let destinationViewController = segue.destination as? AddProduct {
            addTransitionRight()
            destinationViewController.modalPresentationStyle = .fullScreen
        }
    }
}
