//
//  AddressViewModel.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/18/1399 AP.
//

import Firebase
import CoreLocation
import MapKit

class AddressViewModel: ObservableObject {
    var addresses: [String] = []
    var deliveryFee: Double = 0.0
    private var userSession = AuthViewModel.shared.userSession
    
    init() { fetchUserAddresses() }
    
    func getAddresses() -> [String] {
        return self.addresses
    }
    
    func fetchUserAddresses() {
        guard let email = userSession?.email else { return }
        let query = reference(.Users).document(email).collection("Address")
        query.getDocuments { (snapshot, error) in
            self.addresses = []
             if error != nil {
                 print(error!.localizedDescription)
                 return
             }
             guard let snapshot = snapshot else {
                  return
             }
             if !snapshot.isEmpty {
                 for addressDictionary in snapshot.documents {
                     let addressDictionary = addressDictionary.data() as NSDictionary
                     let address = Address(dictionary: addressDictionary as! [String : Any])
                    self.addresses.append(address.address!)
                 }
             }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadedAddresses"), object: nil)
        }
    }
    
    func addNewUserAddress(address: String) {
        guard let email = userSession?.email else { return }
        let data = ["address": address]
        let ref = reference(.Users).document(email).collection("Address").document(address)
        ref.setData(data)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newAddress"), object: nil)
    }
    
    func calcDeliveryFee(address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil { print(error) }
            guard
                let placemarks = placemarks,
                let location = placemarks.first
            else { return }
            
            let mkPlacemark = MKPlacemark(placemark: location)
            let regionDestination: CLLocationDistance = 10000
            
            let coordinates = mkPlacemark.coordinate
            
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDestination, longitudinalMeters: regionDestination)

            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan:  regionSpan.span)
            ]
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            //mapItem.name = "User's Location"
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    func calcDeliveryFee(endCoordinate: CLLocationCoordinate2D) {
        let request:MKDirections.Request = MKDirections.Request()        
        let startAddress = "101 S Mason St, Saginaw, MI 48602"
        var distance: CLLocationDistance?
        request.transportType = MKDirectionsTransportType.automobile;
        request.requestsAlternateRoutes = false
        getCoordinate(addressString: startAddress, completionHandler: { (startCoordinate, error) -> Void in
            if error == nil {
                let startPlacemark = MKPlacemark(coordinate: startCoordinate, addressDictionary: nil)
                let startMapItem = MKMapItem(placemark: startPlacemark)
                let endPlacemark = MKPlacemark(coordinate: endCoordinate, addressDictionary: nil)
                let endMapItem = MKMapItem(placemark: endPlacemark)
                request.source = startMapItem
                request.destination = endMapItem
                let directions = MKDirections(request: request)
                directions.calculate(completionHandler: {
                    response, error in if error == nil {
                        let route = response!.routes[0] as MKRoute
                        distance = route.distance
                        let distanceInMiles = distance!/1609.344
                        self.deliveryFee = distanceInMiles
                        let seconds = route.expectedTravelTime
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calculatedFee"), object: nil)
                     }
               })
            }
        })        
    }
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    func removeUserAddress(address: String, indexPath: IndexPath) {
        guard let email = userSession?.email else { return }
        reference(.Users).document(email).collection("Address").document(address).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.addresses.remove(at: indexPath.row)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "productRemoved"), object: nil)
                print("Document successfully removed!")
            }
        }
    }
    
    func getDeliveryFee() -> String {
        return String(format: "%.2f", deliveryFee)
    }
}
