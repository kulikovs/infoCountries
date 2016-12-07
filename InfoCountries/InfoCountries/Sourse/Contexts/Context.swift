//
//  Context.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/7/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import Alamofire

class Context {
    
    var URLString: String = String()
    
    typealias finishedHandler = (AnyObject) -> Void
    
    var parseFinished: finishedHandler?
    
    private let manager: Alamofire.SessionManager?
    
    //MARK: Initializations and Deallocation
    
    init() {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier:String(describing: type(of: self)))
        self.manager = Alamofire.SessionManager(configuration: sessionConfig)
    }
    
    convenience init(urlString: String) {
        self.init()
        self.URLString = urlString
    }
    
    deinit {
        self.cancel()
    }
    
    //MARK: Public Methods
    
    func load(finished: @escaping finishedHandler) {
        self.parseFinished = finished
        
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
                self?.parseResult(result: result)
            }
        })
        
    }
    
    func cancel() {
        self.manager?.request(self.URLString).cancel()
    }
    
    //MARK: Private Methods
    
    func parseResult(result: NSArray) {
        
    }
    
}
