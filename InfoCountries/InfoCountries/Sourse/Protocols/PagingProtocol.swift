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
    
    func getNextPage() -> Promise<Array<Country>>
    
    func reset() -> Promise<Void>
    
}
