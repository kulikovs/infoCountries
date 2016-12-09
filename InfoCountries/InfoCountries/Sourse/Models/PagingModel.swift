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
    
    var currentPage: Int = 0
    
    var totalPages: Int = 1
    
    var perPage: Int = 12
    
    var country: Country?
    
    var countries: Array <AnyObject> = Array()
    
    //MARK: Initializations and deallocations
    
    init(finishedBlock: @escaping pagingFinishedBlock) {
        self.pagingFinished = finishedBlock
    }
    
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
            self.context?.load(finished: contextDidLoad())
        }
    }
    
    // MARK: Public Methods
    
    func getNextPage() {
        if self.currentPage < self.totalPages {
            self.currentPage += 1
            self.context = CountriesContext(urlString: self.countriesRequestString)
        }
    }
    
    func getPreviousPage() {
        if self.currentPage > 1 {
            self.currentPage -= 1
            self.context = CountriesContext(urlString: self.countriesRequestString)
        }
    }
    
    func getInfoFor(country: Country) {
        self.context = CountryDetailContext(urlString: self.countryRequestString)
    }
    
    //MARK: Privat Methods
    
   fileprivate func contextDidLoad() -> contextFinishedBlock {
        
        return { [weak self] (arr: AnyObject, pages: Any) -> Void in
            self?.countries = arr as! Array<AnyObject>
            self?.totalPages = pages as! Int
            self?.pagingFinished!(self?.countries as AnyObject)
        }
    }

}
