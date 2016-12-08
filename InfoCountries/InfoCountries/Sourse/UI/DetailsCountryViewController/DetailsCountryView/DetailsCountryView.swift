//
//  DetailsCountryView.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit

class DetailsCountryView: UIView, CellProtocol {

    @IBOutlet var nameLabel:         UILabel?
    @IBOutlet var capitalLabel:      UILabel?
    @IBOutlet var populationLabel:   UILabel?
    @IBOutlet var callingCodeLabel:  UILabel?
    @IBOutlet var numericCodeLabel:  UILabel?

   internal func fillWith(model: Country) {
        self.nameLabel?.text = model.name
        self.capitalLabel?.text = model.capital
        self.populationLabel?.text = String(model.population)
        self.callingCodeLabel?.text = String(model.callingCode)
        self.numericCodeLabel?.text = String(model.numericCode)
    }
}
