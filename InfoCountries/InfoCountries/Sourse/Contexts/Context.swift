//
//  Context.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/7/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class Context: ContextProtocol {

    typealias ResultType = Any
    
    var request: DataRequest?

    //MARK: - Initializations and Deallocation
    
    deinit {
        self.cancel()
    }
    
    //MARK: - Accessors
    
    var URLString: String {
        get {
            return String()
        }
    }
    
    //MARK: - Public Methods
    
    func load() -> Promise<ResultType> {
        return Promise(resolvers: { fulfill, reject in
            
            request = Alamofire.request(self.URLString).responseJSON(completionHandler: {[weak self] response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                if let result: NSArray = (response.result.value as! NSArray?) {
                    self?.parse(result: result, resolve: (fulfill, reject))
                } else {
                    reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                }
            })
            
        })
        
    }
    
    func cancel() {
        self.request?.cancel()
    }
    
    //MARK: - Private Methods
    
    func parse(result: NSArray, resolve: (fulfill: ((Any) -> Void), reject: ((Error) -> Void))) {
        
    }
    
}
