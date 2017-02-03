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

final class CountriesContext: PagingContextProtocol {
    
    typealias ResultType = Array<Country>

    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    var currentPage:    Int = Paging.baseCurrentPage
    var perPage:        Int = Paging.basePerPage
    var totalPages:     Int = Paging.baseTotalPages
    
    var dataTask: URLSessionDataTask?
    
    var requestString: String {
        get {
            return Context.Request.countriesURLString + "per_page=\(self.perPage)&format=json&page=\(self.currentPage)"
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
           download(resolvers: (fulfill, reject))
        })
    }
    
    func parse(result: Array<Any>, resolve: Resolvers) {
        var countriesArray = Array<Country>()
        MagicalRecord.save( { [weak self] context in
            guard let infoDict = result.first as? Dictionary<String, Any>  else  {
                resolve.reject(NSError.error())
                
                return
            }
            let baseInfo = JSON(infoDict)
            self?.totalPages = baseInfo[Context.Parse.pagesKey].intValue
    
            guard let resultArr = result.last else {
            resolve.reject(NSError.error())
                
                return
            }
<<<<<<< HEAD
            if countries.first == nil {
                reject(NSError(domain: "", code: 0, userInfo: nil))
            } else {
                fulfill(countries)
=======
            let resultArray = JSON(resultArr)
            for country in resultArray.arrayValue {
                let name = country[Context.Parse.nameKey].stringValue
                let countryModel = Country.mr_findFirstOrCreate(byAttribute: Context.Parse.nameKey,
                                                                withValue: name,
                                                                in: context)
                countryModel.latitude = country[Context.Parse.latitudeKey].doubleValue
                countryModel.longitude = country[Context.Parse.longitudeKey].doubleValue
                
                countriesArray.append(countryModel)
>>>>>>> feature/single_promise_
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
