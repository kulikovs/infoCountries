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
    
    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    let countryName: String
    
    internal var dataTask: URLSessionDataTask?
    
    var requestString: String {
        get {
            let urlString = Context.Request.countryURLString + self.countryName
            return urlString.addingPercentEncodingForUrlQuery()!
        }
    }
    
    //MARK: - Initializations and deallocations
    
    init(countryName: String) {
        self.countryName = countryName
    }
    
    // MARK: - Initializations and deallocations
    
    deinit {
        self.cancel()
    }

    // MARK: - Public methods
    
    func load() -> Promise<Country> {
        return Promise(resolvers: { fulfill, reject in
            download(resolvers: (fulfill, reject))
        })
    }
    
    func parse(result: Array<Any>, resolve: Resolvers) {
        var countryModel: Country?
        MagicalRecord.save({ [weak self] context in
            guard let selfRef = self else {
                resolve.reject(NSError.error())
                return
            }
            let resultArray = JSON(result)
            for country in resultArray.arrayValue {
                countryModel = Country.mr_findFirst(byAttribute:Context.Parse.nameKey,
                                                    withValue: selfRef.countryName,
                                                    in: context)
                countryModel?.capital = country[Context.Parse.capitalKey].string
                countryModel?.population = country[Context.Parse.populationKey].int64Value
                countryModel?.numericCode = country[Context.Parse.numericCodeKey].int16Value
                if let callingCode = country[Context.Parse.callingCodesKey].array?.first?.int16 {
                    countryModel?.callingCode = callingCode
                }
                
            }
            }, completion: { (success, error) in
                if let error = error {
                    resolve.reject(error)
                } else {
                    countryModel = countryModel?.mr_(in: NSManagedObjectContext.mr_default())
                    if countryModel != nil {
                        resolve.fulfill(countryModel!)
                    } else {
                        resolve.reject(NSError.error())
                    }
                }
        })
    }
    
}
