//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import PromiseKit

protocol ContextProtocol: class {
    
    associatedtype ResultType
    
    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    func load() -> Promise<ResultType>
    
    func parse(result: NSArray, resolve: Resolvers)
    
    func cancel()
}

