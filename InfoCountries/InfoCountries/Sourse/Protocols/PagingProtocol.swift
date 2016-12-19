//
//  PagingProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/9/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

typealias pagingFinishedBlock = (Array<AnyObject>) -> Void

protocol PagingProtocol {
    
    func getNextPage()
    
    func reset()
    
}
