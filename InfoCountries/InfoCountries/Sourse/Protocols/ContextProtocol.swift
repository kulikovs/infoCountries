//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

protocol ContextProtocol: class {
    
    typealias finishedHandler = (AnyObject, Any) -> Void

    func load(finished: @escaping finishedHandler)
    
    func parse(result: NSArray)
}
