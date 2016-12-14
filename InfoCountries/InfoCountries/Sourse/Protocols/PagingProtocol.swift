//
//  PagingProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/9/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

typealias pagingFinishedBlock = (Array<Any>) -> Void

protocol PagingProtocol {
    
    var currentPage: Int {get set}  //get
    
    var totalPages: Int {get set}   //let
    
    var perPage: Int {get set}  //get, move to init
    
    func getNextPage()
    
    func getPreviousPage() //
    
    func getCountryInfo() //
    
    func reset()
    
}
