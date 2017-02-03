//
//  NSError+Extensions.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 2/2/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import Foundation

extension NSError {
    
    class func error() -> NSError {
        return NSError.error(with: "")
    }
    
    class func error(with string: String) -> NSError {
        return  NSError(domain: string, code: 0, userInfo: nil)
    }
    
}
