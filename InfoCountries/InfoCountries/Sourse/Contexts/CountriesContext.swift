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

let baseCurrentPage = 0
let baseTotalPages  = 1
let basePerPage     = 12

class CountriesContext: PagingContextProtocol {
    
    typealias ResultType = Array<Country>
    
    var currentPage:    Int = baseCurrentPage
    var perPage:        Int = basePerPage
    var totalPages:     Int = baseTotalPages
    
    var URLString: String {
        get {
            return countriesURLString + "per_page=\(self.perPage)&format=json&page=\(self.currentPage)"
        }
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
            Alamofire.request(self.URLString).responseJSON(completionHandler: {[weak self] response in
                if let result: NSArray = (response.result.value as! NSArray?) {
                    self?.parse(result: result, resolve: (fulfill, reject))
                } else {
                    reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                }
            })
            
        })
    }
    
    func cancel() {
        
    }
    
    func parse(result: NSArray, resolve: (fulfill: ((Array<Country>) -> Void), reject: ((Error) -> Void))) {
        var countriesArray = Array<Country>()
        MagicalRecord.save({ [weak self] context in
            let baseInfo = JSON(result.firstObject as! NSDictionary)
            self?.totalPages = baseInfo[pagesKey].int!
            
            let resultArray = JSON(result.lastObject as! NSArray)
            for country in resultArray.array! {
                let name = country[nameKey].string!
                let countryModel = Country.mr_findFirstOrCreate(byAttribute: nameKey,
                                                                withValue: name,
                                                                in: context)
                countriesArray.append(countryModel)
            }
            }, completion: { [weak self] (success, error) in
                if let error = error {
                    resolve.reject(error)
                } else {
                    self?.updated(countriesArray, resolve: resolve)
                }
        })
    }

    
    //MARK: - Private Methods
    
    private func updated(_ countries:[Country],
                                  resolve: (fulfill: ((Array<Country>) -> Void), reject: ((Error) -> Void))) {
        var updated = Array<Country>()

        for country in (countries) {
            let countryModel = country.mr_(in: NSManagedObjectContext.mr_default())!
            updated.append(countryModel)
        }
        resolve.fulfill(countries)
    }
    
    
}


