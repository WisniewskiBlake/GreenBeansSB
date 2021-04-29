//
//  TimeViewController.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 3/17/21.
//

import UIKit
//import JSSAlertView

class TimeViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var order: Order?
    var cartViewModel: CartViewModel?
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        let dateComps = datePicker.calendar.dateComponents([.month, .day, .year, .hour, .minute, .second], from: datePicker.date)
        let currentDate = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute, .second], from: Date())
        
        if dateComps.hour! > 9 && dateComps.hour! < 18 || !(dateComps.day! == currentDate.day! && dateComps.hour! < currentDate.hour!) ||  !(dateComps.day! == currentDate.day! && dateComps.hour! == currentDate.hour! && dateComps.minute! < currentDate.minute!) {
            if datePicker.calendar.date(from: dateComps)! < Calendar.current.date(from: currentDate)! {
                helper.showAlert(title: "Date selected is in the past", message: "", in: self)
            } else {
                order?.pickUpTime = helper.getDateAsString(dateComps: dateComps)
                if order?.orderType == "pickUp" {
                    performSegue(withIdentifier: "SelectPickUpAddress", sender: self)
                } else {
                    performSegue(withIdentifier: "EnterGuestAddress", sender: self)
                    //performSegue(withIdentifier: "GuestAddressSearch", sender: self)
                }
            }            
        } else {
            helper.showAlert(title: "Business hours are 9am-6pm", message: "", in: self)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        addTransitionLeft()
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPickUpAddress", let pickUpViewController = segue.destination as? PickupViewController {
            pickUpViewController.cartViewModel = cartViewModel
            pickUpViewController.order = order
            pickUpViewController.modalPresentationStyle = .fullScreen
        }
        if segue.identifier == "EnterGuestAddress", let pickUpViewController = segue.destination as? GuestAutoAddr {
            pickUpViewController.cartViewModel = cartViewModel
            pickUpViewController.order = order
            pickUpViewController.modalPresentationStyle = .fullScreen
        }
        
    }
}
