//
//  LocationPin.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-22.
//

import Foundation
import MapKit

/**
    This will be used to place a pin of the location on the MapView
 */

class LocationPin: NSObject, MKAnnotation{
    
    //MARK: Properties
    var title: String?
    var details: String?
    var coordinate: CLLocationCoordinate2D
    
    //MARK: Methods
    /*
        Creating our location item
     */
    var mapItem: MKMapItem?{
        guard let location = title else { return nil }
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location
        
        return mapItem
    }
    
    /*
        Class initializer
     */
    init(title: String, coordinate: CLLocationCoordinate2D, description: String) {
        self.title = title
        self.details = description
        self.coordinate = coordinate
    }
}
