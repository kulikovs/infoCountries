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
    
    var sessionConfig: URLSessionConfiguration?
    
    var manager: Alamofire.SessionManager?

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
    
    func load() -> Promise<AnyObject> {
        return Promise(resolvers: { fulfill, reject in
            self.setupSessionConfig()
            
            self.manager?.request(self.URLString).responseJSON(completionHandler: {[weak self] response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                if let result: NSArray = (response.result.value as! NSArray?) {
                    self?.parse(result: result).then { countries -> Void  in
                        fulfill(countries as AnyObject)
                        }.catch {error in
                            print(error)
                    }
                } else {
                    reject(NSError.init(domain: "world.org", code: 0, userInfo: nil))
                }
            })
        })
        
    }
    
    func cancel() {
        self.manager?.request(self.URLString).cancel()
    }
    
    //MARK: - Private Methods
    
    func parse(result: NSArray) -> Promise<AnyObject> {
        return Promise(resolvers: {fulfill in  })
    }
    
   func setupSessionConfig() {
        self.sessionConfig = URLSessionConfiguration.background(withIdentifier:self.URLString)
        self.manager = Alamofire.SessionManager(configuration: self.sessionConfig!)
    }
    
}
