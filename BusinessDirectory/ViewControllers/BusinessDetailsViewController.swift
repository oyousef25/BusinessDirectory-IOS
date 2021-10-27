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
    //Core data stack that we are going to use to add the new business to the contactList
    lazy var coreDataStack = CoreDataStack(modelName: "BusinessDirectory")
        
    var business: Business? //This is the passed business object that we are going to use
    
    
    //MARK: Outlets
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var companyHead: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Unwrapping our passed business object
        if let business = business {
            //Using the passed business object to set our UI elements to their correct values
            companyName.text = business.businessName
            companyHead.text = business.companyHead
            contactNumber.text = business.contactNumber
        }
        
        /*
         Styling our mapview
         */
        mapview.layer.cornerRadius = 15
        mapview.isScrollEnabled = false
        mapview.isZoomEnabled = false
        
        centerOnPin()
    }
    
    //MARK: Methods
    //This method will add a pin to our mapview
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
        
        //Creating a new empty instance of the core data object
        let newContactList = ContactList(context: coreDataStack.managedContext)
        
        //Setting it's vlues to whatever the seleted cell have
        newContactList.contactName = business.companyHead
        newContactList.companyName = business.businessName
        newContactList.contactNumber = business.contactNumber
        newContactList.contactLogo = business.companyLogo
        //newContactList.products = business.products

        //Save the changes made to our core data
        coreDataStack.saveContext()
        
        /*
            Create an alert controller to display the contact name that was added to contacts
         */
        let ac = UIAlertController(title: "Added!", message: "\(business.companyHead ?? "") has been added to your contacts", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}
