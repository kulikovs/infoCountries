//
//  PagingModel.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

class PagingModel: PagingProtocol {
    
    var pagingFinished: pagingFinishedBlock?
    
    var currentPage: Int = baseCurrentPage
    
    var totalPages: Int = basetotalPages
    
    var perPage: Int = basePerPage
    
    var country: Country?
    
    var countries: Array <AnyObject> = Array()
    
    //MARK: - Initializations and deallocations

    init(finishedBlock: @escaping pagingFinishedBlock) {
        self.pagingFinished = finishedBlock
    }

    //MARK: - Accessors
    
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
            self.context?.load()
        }
    }
    
    // MARK: - Public Methods
    
    func getNextPage() {
        if self.currentPage < self.totalPages {
            self.currentPage += 1
            self.context = CountriesContext(urlString: self.countriesRequestString,
                                            finished: self.countriesContextDidLoad())
        }
    }
    
    func getPreviousPage() {
        if self.currentPage > 1 {
            self.currentPage -= 1
            self.context = CountriesContext(urlString: self.countriesRequestString,
                                            finished: self.countriesContextDidLoad())
        }
    }
    
    func getCountryInfo() {
        let context = CountryDetailContext(urlString: self.countryRequestString,
                                            finished: self.countryContextDidLoad())
        context.country = self.country
        self.context = context
    }
    
    //MARK: - Privat Methods
    
   fileprivate func countriesContextDidLoad() -> contextFinishedBlock {

        return { [weak self] (arr: AnyObject, pages: Any) -> Void in
            self?.countries = arr as! Array<AnyObject>
            self?.totalPages = pages as! Int
            self?.pagingFinished!(self?.countries as AnyObject)
        }
    }
    
    fileprivate func countryContextDidLoad() -> contextFinishedBlock {
        
        return { [weak self] (_ model: AnyObject, _ pages: Any) -> Void in
            self?.country = model as? Country
            self?.pagingFinished!(self?.country as AnyObject)
        }
    }

}
