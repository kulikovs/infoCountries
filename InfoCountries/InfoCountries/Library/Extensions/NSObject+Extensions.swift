//
//  NSObject+Extensions.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

public extension NSObject{
    public class var className: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
