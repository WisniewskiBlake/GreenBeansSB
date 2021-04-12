//
//  GuestAutoAddr.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 4/6/21.
//

import UIKit
import GooglePlaces

class GuestAutoAddr: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var addressViewModel = AddressViewModel()
    var order: Order?
    var cartViewModel: CartViewModel?
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadedFee), name: NSNotification.Name(rawValue: "calcFee"), object: nil)
        
        searchBar.delegate = self
        view.addSubview(searchBar)

        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let backgroundImage = getImageWithCustomColor(color: UIColor.clear, size: CGSize(width: 265, height: 60))
        searchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)

        
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource

        view.addSubview(tableView)
      }
    override func viewDidLayoutSubviews() {
        self.searchBar.layoutIfNeeded()
        self.searchBar.layoutSubviews()
        
        
        self.searchBar.searchTextField.font = .systemFont(ofSize: 25.0)
        //Your custom text size
        
        searchBar.layoutIfNeeded()
        searchBar.layoutSubviews()
    }
    
    @objc func loadedFee() {
        order?.deliveryFee = addressViewModel.getDeliveryFee()
        performSegue(withIdentifier: "ContactInfo", sender: self)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactInfo", let guestContactVC = segue.destination as? GuestContactViewController {
            guestContactVC.cartViewModel = cartViewModel
            guestContactVC.order = order
            guestContactVC.modalPresentationStyle = .fullScreen
        }
    }
}

extension GuestAutoAddr: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // Update the GMSAutocompleteTableDataSource with the search text.
    tableDataSource.sourceTextHasChanged(searchText)
  }
}

extension GuestAutoAddr: GMSAutocompleteTableDataSourceDelegate {
  func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator off.
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    // Reload table data.
    tableView.reloadData()
  }

  func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator on.
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    // Reload table data.
    tableView.reloadData()
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
    searchBar.searchTextField.text = place.name
    DispatchQueue.main.async {
        self.addressViewModel.getCoordinate(addressString: place.formattedAddress!, completionHandler: { (coordinate, error) -> Void in
            if error == nil {
                self.addressViewModel.calcDeliveryFee(endCoordinate: coordinate)
                self.order?.customerAddress = place.formattedAddress!
            }
        })
    }
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
    // Handle the error.
    print("Error: \(error.localizedDescription)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
    
    return true
  }
}

extension GuestAutoAddr {
    func getImageWithCustomColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
