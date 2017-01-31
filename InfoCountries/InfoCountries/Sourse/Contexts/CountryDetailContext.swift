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

private let kCountryURLString = "https://restcountries.eu/rest/v1/name/"

final class CountryDetailContext: ContextProtocol {

    typealias ResultType = Country
    
    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    let countryName: String
    
    private var request: DataRequest?
    
    var requestString: String {
        get {
            let urlString = kCountryURLString + self.countryName
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
            self.request = loadAlamofire(resolvers: (fulfill, reject))
        })
    }
    
    func cancel() {
        request?.cancel()
    }
    
    func parse(result: NSArray, resolve: Resolvers) {
        var countryModel: Country?
        MagicalRecord.save({ [weak self] context in
            guard let selfRef = self else {
                resolve.reject(kNSError)
                return
            }
            let resultArray = JSON(result)
            for country in resultArray.arrayValue {
                countryModel = Country.mr_findFirst(byAttribute: kNameKey,
                                                    withValue: selfRef.countryName,
                                                    in: context)
                countryModel?.capital = country[kCapitalKey].string
                countryModel?.population = country[kPopulationKey].int64Value
                countryModel?.numericCode = country[kNumericCodeKey].int16Value
                let codes = country[kCallingCodesKey].arrayValue
                for code in codes {
                    countryModel?.callingCode = code.int16Value
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
                        resolve.reject(kNSError)
                    }
                }
        })
    }

    
}
