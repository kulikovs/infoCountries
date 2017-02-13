//
//  PagingModel.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import RxSwift

class PagingModel<T: PagingContextProtocol>: PagingProtocol {
    
    typealias PagingType = T.ResultType
    
    var context: T

    var totalPages: Int {
        get {
            return context.totalPages
        }
    }
    
    var currentPage: Int {
        get {
            return context.currentPage
        }
    }
    
    var perPage: Int {
        get {
            return context.perPage
        }
    }
    
    //MARK: - Initializations and deallocations
    
    init(context: T, perPage: Int) {
        self.context = context
        self.context.setPageSize(perPage)        
    }
    
    // MARK: - Public Methods
    
    func cancel() {
        context.cancel()
    }

    func getNextPage() -> Observable<T.ResultType> {
        context.setPage(currentPage + 1)
        return context.load()
    }
    
    func reset() {
        context.setPage(Paging.baseCurrentPage)
    }

}
