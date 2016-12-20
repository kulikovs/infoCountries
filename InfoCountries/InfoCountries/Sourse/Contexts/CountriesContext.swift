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

class CountriesContext: Context, PagingContextProtocol {
    
    typealias ResultType = [Country]
    
    var currentPage: Int = baseCurrentPage
    
    var perPage: Int = basePerPage
    
    var totalPages: Int = baseTotalPages
    
    var countriesArray = Array<Country>()
    
    // MARK: - Accessors
    
    override var URLString: String {
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
    
    // MARK: -  Overriden methods
    
    func parse(result: NSArray, resolve: (fulfill: ((Array<Country>) -> Void), reject: ((Error) -> Void))) {
        self.countriesArray = Array()
        MagicalRecord.save({ [weak self] context in
            let baseInfo = JSON(result.firstObject as! NSDictionary)
            self?.totalPages = baseInfo[pagesKey].int!
            
            let resultArray = JSON(result.lastObject as! NSArray)
            for country in resultArray.array! {
                let name = country[nameKey].string!
                let countryModel = Country.mr_findFirstOrCreate(byAttribute: nameKey,
                                                                withValue: name,
                                                                in: context)
                self?.countriesArray.append(countryModel)
            }
            }, completion: { [weak self] (success, error) in
                if let error = error {
                    resolve.reject(error)
                } else {
                    self?.countriesUpdated(resolve: resolve)
                }
        })
    }

    
    //MARK: - Private Methods
    
    func countriesUpdated(resolve: (fulfill: ((Array<Country>) -> Void), reject: ((Error) -> Void))) {
        var countries: Array<Country> = Array<Country>()
        
        for country in (self.countriesArray) {
            let countryModel = country.mr_(in: NSManagedObjectContext.mr_default())!
            countries.append(countryModel)
        }
        if countries.first == nil {
            resolve.reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
        } else {
            resolve.fulfill(countries)
        }
    }
    
}

