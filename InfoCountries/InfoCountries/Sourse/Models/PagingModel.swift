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
    
    var context: PagingContextProtocol & ContextProtocol
    
    //MARK: - Accessors

    var totalPages: Int {
        get {
            return self.context.totalPages
        }
    }
    
    var currentPage: Int {
        get {
            return self.context.currentPage
        }
    }
    
    var perPage: Int {
        get {
            return self.context.perPage
        }
    }
    
    //MARK: - Initializations and deallocations
    
    
    
    init <T: PagingContextProtocol & ContextProtocol>(context: T,
                                                      perPage: Int,
                                                finishedBlock: @escaping pagingFinishedBlock)
    {
        self.context = context
        self.context.setPageSize(perPage)
        self.pagingFinished = finishedBlock
        self.context.contextFinished = { [weak self] (countries: AnyObject) -> Void  in
                                         self?.pagingFinished!(countries as! Array<AnyObject>)
                                        }
    }
    
    // MARK: - Public Methods
    
    func getNextPage() {
        if self.currentPage < self.totalPages {
            self.context.setPage(self.currentPage + 1)
            self.context.load()
        }
    }
   
    func reset() {
        self.context.setPage(baseCurrentPage)
        self.pagingFinished!(Array())
    }

}
