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
    
    var context: CountriesContext?
    
    var countries: Array <AnyObject> = Array()
    
    //MARK: - Accessors

    var totalPages: Int {
        get {
            return self.context!.totalPages
        }
    }
    
    var currentPage: Int {
        get {
            return self.context!.currentPage
        }
    }
    
    var perPage: Int {
        get {
            return self.context!.perPage
        }
    }
    
    //MARK: - Initializations and deallocations
    
     init(perPage: Int, finishedBlock: @escaping pagingFinishedBlock) {
        self.context?.setPageSize(perPage)
        self.pagingFinished = finishedBlock
        self.context = CountriesContext(finished:{ [weak self] (countries: AnyObject) -> Void in
                                                    self?.countries.append(contentsOf: countries as! Array<AnyObject>)
                                                    self?.pagingFinished!((self?.countries)!)
                                                    })
    }
    
    // MARK: - Public Methods
    
    func getNextPage() {
        if self.currentPage < self.totalPages {
            self.context?.setPage(self.currentPage + 1)
            self.context?.load()
        }
    }
   
    func reset() {
        self.countries.removeAll()
        self.context?.setPage(baseCurrentPage)
        self.pagingFinished!(self.countries)
    }

}
