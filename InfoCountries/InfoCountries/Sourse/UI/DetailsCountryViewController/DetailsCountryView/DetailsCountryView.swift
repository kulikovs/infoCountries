//
//  DetailsCountryView.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import MapKit

private let kLocationDistance = 10000

class DetailsCountryView: UIView, FillingProtocol {
    
    @IBOutlet var nameLabel:         UILabel?
    @IBOutlet var capitalLabel:      UILabel?
    @IBOutlet var populationLabel:   UILabel?
    @IBOutlet var callingCodeLabel:  UILabel?
    @IBOutlet var numericCodeLabel:  UILabel?
    @IBOutlet var map:               MKMapView?
    
    //MARK: - Cell Protocol
    
    internal func fillWith(model: Country) {
        self.nameLabel?.text = model.name
        self.capitalLabel?.text = model.capital
        self.populationLabel?.text = String(model.population)
        self.callingCodeLabel?.text = String(model.callingCode)
        self.numericCodeLabel?.text = String(model.numericCode)
        
        self.setupMapWith(model: model)
    }
    
    //MARK: - Private Methods
    
    private func setupMapWith(model: Country) {
        let location = CLLocationCoordinate2DMake(model.latitude, model.longitude)
        let locationDistance = CLLocationDistance(kLocationDistance)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, locationDistance, locationDistance)
        
        let map = self.map
        map?.setRegion(coordinateRegion, animated: true)
        map?.addAnnotation(MapAnnotation(coordinate: location, title: model.capital))
    }
    
}
