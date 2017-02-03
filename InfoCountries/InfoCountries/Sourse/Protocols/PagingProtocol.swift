//
//  PagingProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/9/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import PromiseKit

protocol PagingProtocol {
    
    associatedtype PagingType
    
    func getNextPage() -> Promise<PagingType>
    
    func reset()
    
    func cancel()
    
}
