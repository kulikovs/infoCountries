//
//  CountryContext.swift
//  InfoCountries
//
//  Created by VladislavEmets on 12/20/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import MagicalRecord
import SwiftyJSON

private let kCountryURLString = "https://restcountries.eu/rest/v1/name/"

class CountryContext {
    
    typealias ResultType = Country
    
    func someCancellablePromise() -> (Promise<Country>, () -> Void) {
        
        let (promise, fulfill, reject) = Promise<Country>.pending()
        let request = Alamofire.request("").responseJSON(completionHandler: {response in
            if let result = (response.result.value as? NSArray) {
                self.parse(name: "", result: result, resolve: (fulfill, reject))
            } else {
                reject(NSError(domain: "", code: 0, userInfo: nil))
            }
        })
        
        return (promise, {
            request.cancel()
            reject(NSError(domain: "Canceled", code: 0, userInfo: nil))
        })
    }
    
    func load(country: String) -> Promise<ResultType> {
        let requestString = self.requestStringWith(country: country)
        
        return Promise(resolvers: { fulfill, reject in
            
            Alamofire.request(requestString).responseJSON(completionHandler: {response in
                if let result = (response.result.value as? NSArray) {
                    self.parse(name: country, result: result, resolve: (fulfill, reject))
                } else {
                    reject(NSError.init(domain: "", code: 0, userInfo: nil))
                }
            })
        })
    }
    
    func parse(name: String, result: NSArray, resolve: (fulfill: ((Country) -> Void), reject: ((Error) -> Void))) {
        var countryModel: Country?
        MagicalRecord.save({context in
            let resultArray = JSON(result)
            for country in resultArray.arrayValue {
                countryModel = Country.mr_findFirstOrCreate(byAttribute: kNameKey,
                                                            withValue: name,
                                                            in: context)
                countryModel?.capital = country[kCapitalKey].string
                countryModel?.population = country[kPopulationKey].int64Value
                countryModel?.numericCode = country[kNumericCodeKey].int16Value
                let codes = country[kCallingCodesKey].arrayValue
                for code in codes {
                    countryModel?.callingCode = code.int16Value
                }
            }
        }, completion: {(success, error) in
            if let error = error {
                resolve.reject(error)
            } else {
                countryModel = countryModel?.mr_(in: NSManagedObjectContext.mr_default())
                if let result = countryModel {
                    resolve.fulfill(result)
                } else {
                    resolve.reject(NSError(domain: "", code: 0, userInfo: nil))
                }
            }
        })
    }
    
    //MARK: - Private Methods
    
    private func requestStringWith(country: String) -> String {
        let urlString = kCountryURLString + country
        return urlString.addingPercentEncodingForUrlQuery()!
    }
    
}

