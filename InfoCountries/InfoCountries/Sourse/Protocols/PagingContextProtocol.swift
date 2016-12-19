//
//  PagingContextProtocol.swift
//  InfoCountries
//
//  Created by VladislavEmets on 12/14/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

protocol PagingContextProtocol {
    
    var currentPage: Int {get}
    
    var totalPages: Int {get}
    
    var perPage: Int {get}
    
    func setPageSize(_: Int)
    
    func setPage(_: Int)
    
}
