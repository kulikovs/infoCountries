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
    
    typealias Resolvers<T> = (fulfill: ((T)->Void), reject: ((Error)->Void))
    
    var URLString: String {get}
    
    func load<T>() -> Promise<T>
    
    func cancel()
    
    func parse<T>(result: NSArray, resolve: Resolvers<T>)
    
    func setupSessionConfig()
    
}

