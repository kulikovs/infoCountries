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

class CountriesContext {

    let manager = Alamofire.SessionManager(configuration: sessionConfig)
    
    //MARK: Public Methods
    
    var parseFinished = {}
    
    func load() {
     self.manager.request(countriesURLString).responseJSON(completionHandler: { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            if let result: NSArray = response.result.value as! NSArray? {
                self.parseResult(result: result.lastObject as! NSArray)
            }
        })
    }
    
    func cancel() {
        self.manager.request(countriesURLString).cancel()
    }
    
    //MARK: Private Methods
    
    private func parseResult(result: NSArray) {
        MagicalRecord.save({ context in
            let resultArray = JSON(result)
            for country in resultArray.array! {
                let name = country["name"].string!
                _ = Country.mr_findFirstOrCreate(byAttribute: "name", withValue: name, in: context)
            }
        }, completion: {(success, error) in
            if success {
                //self.parseFinished()
            }
            if (error == nil) {
                self.parseFinished()
            }
        })
    }
    
}



