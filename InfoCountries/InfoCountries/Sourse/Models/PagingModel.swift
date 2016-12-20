//
//  PagingModel.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import PromiseKit

class PagingModel<T: PagingContextProtocol>: PagingProtocol {
    
    var context: T
    
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
    
    init(context: T, perPage: Int) {
        self.context = context
        self.context.setPageSize(perPage)
    }
    
    // MARK: - Public Methods
    
    func getNextPage() -> Promise<Array<Country>> {
        return Promise(resolvers: { fulfill, reject in
            let context = self.context
            
            if self.currentPage < self.totalPages {
                context.setPage(self.currentPage + 1)
                context.load().then {countries in
                    fulfill(countries as! Array<Country>)
                }.catch {error in
                    context.setPage(self.currentPage - 1)
                    print(error)

                }
            }
        })
    }
    
    func reset() -> Promise<Void> {
        return Promise(resolvers: { fulfill, reject in
            self.context.setPage(baseCurrentPage)
            fulfill()
        })
    }

}
