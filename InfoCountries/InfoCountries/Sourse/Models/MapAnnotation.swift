//
//  MapAnnotation.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 1/19/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    var title:      String?
    var coordinate: CLLocationCoordinate2D
    var subtitle:   String?
    
    //MARK: - Initializations and deallocations
    
    init(coordinate: CLLocationCoordinate2D, title:String?) {
        self.title = title
        self.coordinate = coordinate
    }
    
    convenience init(latitude: Double, longitude: Double, title: String?) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.init(coordinate: coordinate, title: title)
    }
    
}
