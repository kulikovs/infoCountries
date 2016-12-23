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

//class CountryContext {
//    
//    deinit {
//        print("CountryContext deinit")
//    }

func someCancellablePromise() -> (Promise<Country>, () -> Void) {
    
    let (promise, fulfill, reject) = Promise<Country>.pending()
    
    let request = Alamofire.request("").responseJSON(completionHandler: {response in
        if let status = response.response?.statusCode {
            switch(status) {
            case 201:
                print("example success")
            default:
                print("error with response status: \(status)")
            }
        }
        if let result: NSArray = (response.result.value as! NSArray?) {
            parse(name: " ", result: result, resolve: (fulfill, reject))
        } else {
            reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
        }
    })
    
    return (promise, {
        request.cancel()
        reject(NSError(domain: "Canceled", code: 0, userInfo: nil))
    })
}


    func load(country: String) -> Promise<Country> {
        var requestString = String()
        let urlString = countryURLString + country
        requestString = urlString.addingPercentEncodingForUrlQuery()!
        
        return Promise(resolvers: { fulfill, reject in
            
            Alamofire.request(requestString).responseJSON(completionHandler: {response in
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                if let result: NSArray = (response.result.value as! NSArray?) {
                    parse(name: country, result: result, resolve: (fulfill, reject))
                } else {
                    reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                }
            })
            
        })
    }

    
    func parse(name: String, result: NSArray, resolve: (fulfill: ((Country) -> Void), reject: ((Error) -> Void))) {
        var countryModel: Country?
        MagicalRecord.save({context in
            let resultArray = JSON(result)
            for country in resultArray.array! {
                countryModel = Country.mr_findFirstOrCreate(byAttribute: nameKey,
                                                        withValue:name,
                                                        in: context)
                
                countryModel?.capital = country[capitalKey].string
                countryModel?.population = country[populationKey].int64!
                countryModel?.numericCode = Int16(country[numericCodeKey].string!)!
                let code = country[callingCodesKey].array
                sleep(5)
                countryModel?.callingCode = Int16((code?.first?.string)!)!
            }
            }, completion: {(success, error) in
                if let error = error {
                    resolve.reject(error)
                } else {
                    countryModel = (countryModel?.mr_(in: NSManagedObjectContext.mr_default()))! as Country
                    if let result = countryModel {
                        resolve.fulfill(result)
                    } else {
                        resolve.reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                    }
                }
        })
        
    }

    
//}

