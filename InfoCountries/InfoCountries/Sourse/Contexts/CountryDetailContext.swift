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
import PromiseKit
import Alamofire


final class CountryDetailContext: ContextProtocol {

    typealias ResultType = Country
    
    var country: Country?
    
    private var request: DataRequest?
    
    //MARK: - Accessors
    
    var URLString: String {
        get {
            var requestString = String()
            if self.country != nil {
                let urlString = countryURLString + (self.country?.name)!
                requestString = urlString.addingPercentEncodingForUrlQuery()!
            }
            
            return requestString
        }
    }
    
    // MARK: - Overriden methods
    
    func load() -> Promise<Country> {
        return Promise(resolvers: { fulfill, reject in
            request = loadAlamofire(resolvers: (fulfill, reject))
        })
    }
    
    func cancel() {
        request?.cancel()
    }
    
    func parse(result: NSArray, resolve: (fulfill: ((Country) -> Void), reject: ((Error) -> Void))) {
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
                if let error = error {
                    resolve.reject(error)
                } else {
                    self?.country = (self?.country!.mr_(in: NSManagedObjectContext.mr_default()))! as Country
                    if self?.country != nil {
                        resolve.fulfill((self?.country)!)
                    } else {
                        resolve.reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                    }
                }
        })

    }

    
}
