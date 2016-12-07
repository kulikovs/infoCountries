//
//  CountryDetailContext.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/7/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import MagicalRecord
import SwiftyJSON

class CountryDetailContext: Context {
    
    var country: Country?
    
    override func parseResult(result: NSArray) {
        MagicalRecord.save({ [weak self] context in
            let resultArray = JSON(result)
            for country in resultArray.array! {
                let countryModel = Country.mr_findFirst(byAttribute: nameKey,
                                                        withValue:(self?.country?.name)! as String,
                                                        in: context)
                
                countryModel?.capital = country[capitalKey].string
                countryModel?.population = country[populationKey].int64!
                countryModel?.numericCode = Int16(country[numericCodeKey].string!)!
                let code = country[callingCodesKey].array
                countryModel?.callingCode = Int16((code?.first?.string)!)!
                
                self?.country = countryModel
            }
            }, completion: { [weak self] (success, error) in
                if success {
                    
                }
                if (error == nil) {
                    let countryModel: Country = (self?.country!.mr_(in: NSManagedObjectContext.mr_default()))! as Country
                    self?.parseFinished!(countryModel)
                }
        })
    }
    
}
