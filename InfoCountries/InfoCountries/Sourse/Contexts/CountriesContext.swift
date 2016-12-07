//
//  CountriesContext.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/7/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import MagicalRecord
import SwiftyJSON

class CountriesContext: Context {
    
    var countriesArray = Array<Country>()
    
    override func parseResult(result: NSArray) {
        MagicalRecord.save({ [weak self] context in
            let resultArray = JSON(result.lastObject as! NSArray)
            for country in resultArray.array! {
                let name = country[nameKey].string!
                let countryModel = Country.mr_findFirstOrCreate(byAttribute: nameKey,
                                                                withValue: name,
                                                                in: context)
                self?.countriesArray.append(countryModel)
            }
            }, completion: { [weak self] (success, error) in
                if success {
                    
                }
                if (error == nil) {
                    var countries = Array<Country>()
                    for country in (self?.countriesArray)! {
                        let countryModel = country.mr_(in: NSManagedObjectContext.mr_default())!
                        countries.append(countryModel)
                    }
                    self?.parseFinished!(countries as AnyObject)
                }
        })
    }
    
}
