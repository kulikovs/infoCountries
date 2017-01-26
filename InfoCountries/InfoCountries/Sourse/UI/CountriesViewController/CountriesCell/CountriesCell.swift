//
//  CountriesCell.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit

class CountriesCell: UITableViewCell, CellProtocol{
    @IBOutlet var countryName: UILabel?

    //MARK: - Cell Protocol
    
    func fillWith(model: Country) {
        self.countryName?.text = model.name
    }

}
