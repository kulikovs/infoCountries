//
//  PagingModel.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

class PagingModel: PagingProtocol {
    
    typealias pagingfinishedHandler = (AnyObject) -> Void
    
    var pagingFinished: pagingfinishedHandler?
    
    var currentPage: Int = 0
    
    var totalPages: Int = 1
    
    var perPage: Int = 12
    
    var country: Country?
    
    var countries: Array <AnyObject> = Array()
    
    //MARK: Initializations and deallocations
    
//    init(finished: pagingfinishedHandler) {
//        self.pagingfinished = finished
//    }
    
    //MARK: Accessors
    
    fileprivate var countriesRequestString: String {
        get {
            return countriesURLString + "per_page=\(self.perPage)&format=json&page=\(self.currentPage)"
        }
    }
    
    fileprivate var countryRequestString: String {
        get {
            var requestString = String()
            if self.country != nil {
                let urlString = countryURLString + (self.country?.name)!
                requestString = urlString.addingPercentEncodingForUrlQuery()!
            }
            
            return requestString
        }
    }
    
    fileprivate var context : Context? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            self.context?.load(finished: { [weak self] (_ arr: AnyObject, pages: Any) -> Void in
                self?.countries = arr as! Array<AnyObject>
                self?.totalPages = pages as! Int
                self?.pagingFinished!(self?.countries as AnyObject)
            })
        }
    }
    
    // MARK: Public Methods
    
    func getNextPage(finished: @escaping pagingfinishedHandler) {
        if self.currentPage < self.totalPages {
            self.currentPage += 1
            self.prepareToLoad(finished: finished)
            
        }
    }
    
    func getPreviousPage(finished: @escaping pagingfinishedHandler) {
        if self.currentPage > 1 {
            self.currentPage -= 1
            self.prepareToLoad(finished: finished)
        }
    }
    
    func getInfoFor(country: Country) {
        self.context = CountryDetailContext(urlString: self.countryRequestString)
    }
    
    // MARK: Private Methods
    
    fileprivate func prepareToLoad(finished: @escaping pagingfinishedHandler) {
        self.pagingFinished = finished
        self.context = CountriesContext(urlString: self.countriesRequestString)
    }
}
