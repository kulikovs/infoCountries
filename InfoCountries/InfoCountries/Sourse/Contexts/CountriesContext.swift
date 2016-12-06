//
//  CountriesContext.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/24/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire
import MagicalRecord

let countriesSessionConfig = URLSessionConfiguration.background(withIdentifier: "countriesIdentifier")
var countriesURLString  = "http://api.worldbank.org/country?per_page=10&format=json&page=1"

class CountriesContext : Context {
    
    var countriesArray: Array<AnyObject> = Array()
    
    var parseFinished: Context.finishedHandler?
    
    var manager = Alamofire.SessionManager(configuration: countriesSessionConfig)
    
    var URLString = countriesURLString
    
    //MARK: Private Methods
    
    internal func parseResult(result: NSArray) {
        MagicalRecord.save({ [weak self] context in
            let resultArray = JSON(result.lastObject as! NSArray)
            for country in resultArray.array! {
                let name = country["name"].string!
                _ = Country.mr_findFirstOrCreate(byAttribute: "name", withValue: name, in: context)
            }
            self?.countriesArray = Country.mr_findAllSorted(by: "name", ascending: true)!
            }, completion: { [weak self] (success, error) in
                if success {
                   
                }
                if (error == nil) {
                    self?.parseFinished!((self?.countriesArray)! as AnyObject)
                }
        })
    }
    
}
