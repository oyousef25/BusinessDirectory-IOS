//
//  BusinessDetailsViewController.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-20.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController {
    //MARK: Properties
    var business: Business?
    
    
    //MARK: Outlets
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var companyHead: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let business = business {
            companyName.text = business.businessName
            companyHead.text = business.companyHead
            contactNumber.text = business.contactNumber
        }
        
        mapview.layer.cornerRadius = 15
        mapview.isScrollEnabled = false
        mapview.isZoomEnabled = false
        
        centerOnPin()
    }
    
    func centerOnPin(){
        
        guard let business = business else{ return }
        guard let latitude = business.latitude, let longitude = business.longitude else { return }
                
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        
        mapview.setRegion(coordinateRegion, animated: true)
        
        if let businessName = business.businessName {
            let pin = LocationPin(title: businessName, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), description: "")
            
            mapview.addAnnotation(pin)
        }
    }
    
    
    //MARK: Actions
    @IBAction func saveButtonClicked(_ sender: Any) {
        //Unwrapping the business to use its values in the dialog
        guard let business = business else {
            return
        }
        
        
        /*
            Create an alert controller to display the album name that was added to the cart
         */
        let ac = UIAlertController(title: "Added!", message: "\(business.companyHead ?? "") has been added to your contacts", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}
