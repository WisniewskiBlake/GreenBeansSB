//
//  CustomView.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/12/1399 AP.
//

import UIKit

class CustomView: UIView {

    // make corners rounded for any views (objects)
    func cornerRadius(for view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    
    func cornerRadius(for button: UIButton) {
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
    }
    
    // add blank view to the left side of the TextField (it'll act as a blank gap)
    func padding(for textField: UITextField) {
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = blankView
        textField.leftViewMode = .always
    }
    
    func color(for textField: UITextField) {
        textField.backgroundColor = UIColor(white: 1.0, alpha: 0.15)
        textField.textColor = .white
    }

}

