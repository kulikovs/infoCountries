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

var countriesURLString = "http://api.worldbank.org/country?per_page=10&format=json&page=1"
let sessionConfig = URLSessionConfiguration.background(withIdentifier: "countriesIdentifier")

class CountriesContext : Context {


    //    typealias finishedHandler = (Array<AnyObject>) -> Void
    
//    var parseFinished: Context.finishedHandler?
    
    var manager = Alamofire.SessionManager(configuration: sessionConfig)
    
    var URLString: String {
        return countriesURLString
    }
    
    //MARK: Private Methods
    
    internal func parseResult(result: NSArray) {
        MagicalRecord.save({ context in
            let resultArray = JSON(result)
            for country in resultArray.array! {
                let name = country["name"].string!
                _ = Country.mr_findFirstOrCreate(byAttribute: "name", withValue: name, in: context)
            }
        }, completion: { [weak self] (success, error) in
            if success {
                
            }
            if (error == nil) {
                self?.parseFinished!((self?.countriesArray)!)
            }
        })
    }
    
}
