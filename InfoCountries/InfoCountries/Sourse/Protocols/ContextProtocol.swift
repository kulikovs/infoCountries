//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import Alamofire

typealias contextFinishedBlock = (AnyObject) -> Void

protocol ContextProtocol: class {
    
    var URLString: String {get}
    
    func load()
    
    func cancel()
    
    func parse(result: NSArray)
    
    func setupSessionConfig()
}
