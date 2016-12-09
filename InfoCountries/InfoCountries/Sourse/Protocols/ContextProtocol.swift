//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import Alamofire

typealias contextFinishedBlock = (AnyObject, Any) -> Void

protocol ContextProtocol: class {
    
  //  typealias contextFinishedBlock = (AnyObject, Any) -> Void
    
    var URLString: String {get set}
    
    func load(finished: @escaping contextFinishedBlock)
    
    func parse(result: NSArray)
    
    func setupSessionConfig()
}
