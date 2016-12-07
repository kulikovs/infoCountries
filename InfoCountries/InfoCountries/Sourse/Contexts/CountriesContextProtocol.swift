//
//  CountriesContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/24/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire
import MagicalRecord

//let countriesSessionConfig = URLSessionConfiguration.background(withIdentifier: countriesSessionIdentifire)
//
//class CountriesContextProtocol : ContextProtocol {
//    
//    var countriesArray: Array<AnyObject> = Array()
//    
//    var parseFinished: ContextProtocol.finishedHandler?
//    
//    var manager = Alamofire.SessionManager(configuration: countriesSessionConfig)
//    
//    var URLString = countriesURLString
//    
//    //MARK: Private Methods
//    
//    internal func parseResult(result: NSArray) {
//        MagicalRecord.save({ [weak self] context in
//            let resultArray = JSON(result.lastObject as! NSArray)
//            for country in resultArray.array! {
//                let name = country[nameKey].string!
//                let countryModel = Country.mr_findFirstOrCreate(byAttribute: nameKey,
//                                                                withValue: name,
//                                                                in: context)
//                self?.countriesArray.append(countryModel)
//            }
//            }, completion: { [weak self] (success, error) in
//                if success {
//                    
//                }
//                if (error == nil) {
//                    var countries = Array<Country>()
//                    for country in (self?.countriesArray)! {
//                        let countryModel = country.mr_(in: NSManagedObjectContext.mr_default())! as! Country
//                        countries.append(countryModel)
//                    }
//                    self?.parseFinished!(countries as AnyObject)
//                }
//        })
//    }
//    
//}
