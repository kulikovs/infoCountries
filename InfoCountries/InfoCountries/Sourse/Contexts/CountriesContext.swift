//
//  CountriesContext.swift
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

let kBaseCurrentPage = 0
let kBaseTotalPages  = 1
let kBasePerPage     = 12

private let kCountriesURLString  = "http://api.worldbank.org/country?"

final class CountriesContext: PagingContextProtocol {
    
    typealias ResultType = Array<Country>

    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    var currentPage:    Int = kBaseCurrentPage
    var perPage:        Int = kBasePerPage
    var totalPages:     Int = kBaseTotalPages
    
    private var request: DataRequest?
    
    var requestString: String {
        get {
            return kCountriesURLString + "per_page=\(self.perPage)&format=json&page=\(self.currentPage)"
        }
    }
    
      // MARK: - Initializations and deallocations
    
    deinit {
        self.cancel()
    }
    
  //  MARK: - PagingContextProtocol
    
    func setPageSize(_ pageSize: Int) {
        self.perPage = pageSize
    }
    
    func setPage(_ page: Int) {
        self.currentPage = page
    }
    
    // MARK: -  Public methods
    
    func load() -> Promise<Array<Country>> {
        return Promise(resolvers: { fulfill, reject in
            self.request = loadAlamofire(resolvers: (fulfill, reject))
        })
    }
    
    func cancel() {
        if self.request != nil {
            self.request?.cancel()
        }
    }
    
    func parse(result: NSArray, resolve: Resolvers) {
        var countriesArray = Array<Country>()
        MagicalRecord.save({ [weak self] context in
            let baseInfo = JSON(result.firstObject as? NSDictionary)
            self?.totalPages = baseInfo[kPagesKey].intValue
    
            let resultArray = JSON(result.lastObject as? NSArray)
            for country in resultArray.arrayValue {
                let name = country[kNameKey].stringValue
                let countryModel = Country.mr_findFirstOrCreate(byAttribute: kNameKey,
                                                                withValue: name,
                                                                in: context)
                countryModel.latitude = country[kLatitudeKey].doubleValue
                countryModel.longitude = country[kLongitudeKey].doubleValue
                
                countriesArray.append(countryModel)
            }
            }, completion: { [weak self] (success, error) in
                if let error = error {
                    resolve.reject(error)
                } else {
                    self?.update(countriesArray, resolve: resolve)
                }
        })
    }

    //MARK: - Private Methods
    
    private func update(_ countries:[Country], resolve: (Resolvers)) {
        var updated = Array<Country>()
        
        for country in (countries) {
            if let countryModel = country.mr_(in: NSManagedObjectContext.mr_default()) {
                updated.append(countryModel)
            }
        }
        resolve.fulfill(updated)
    }
    
}
