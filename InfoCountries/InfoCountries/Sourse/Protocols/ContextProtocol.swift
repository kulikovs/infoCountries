//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

protocol ContextProtocol: class {
    
    associatedtype ResultType
    
    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    var requestString:String{get}
    
    func load() -> Promise<ResultType>
    
    func parse(result: NSArray, resolve: Resolvers)
    
    func cancel()
}

extension ContextProtocol {
    
    func loadAlamofire(resolvers: Resolvers) -> DataRequest {
        return Alamofire.request(requestString).responseJSON(completionHandler: {[weak self] response in
            if let result: NSArray = (response.result.value as? NSArray) {
                self?.parse(result: result, resolve: resolvers)
            } else {
                resolvers.reject(kNSError)
            }
        })
    }
    
}

