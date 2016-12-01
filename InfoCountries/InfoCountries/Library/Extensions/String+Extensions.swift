//
//  String+Category.swift
//  TestSwiftUI
//
//  Created by Vladimir Budniy on 11/21/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

extension String {
    public static func nameOfClass(cellClass: AnyClass) -> String {
        return (NSStringFromClass(cellClass).components(separatedBy: ".").last)!
    }
}
