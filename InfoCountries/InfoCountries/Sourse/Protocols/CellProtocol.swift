//
//  CellProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

protocol CellProtocol {
    
    associatedtype ItemType
    
    func fillWith(model: ItemType)
    
}
