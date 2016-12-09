//
//  PagingProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/9/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

protocol PagingProtocol {
    
    typealias pagingfinishedHandler = (AnyObject) -> Void
    
    var currentPage: Int {get set}
    
    var totalPages: Int {get set}
    
    var perPage: Int {get set}
    
    func getNextPage()
    
    func getPreviousPage()
    
    func getInfoFor(country: Country)
    
}
