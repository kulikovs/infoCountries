//
//  Context.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/1/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MagicalRecord

public protocol Context {
    
    typealias finishedHandler = (Array<AnyObject>) -> Void
    
    var URLString: String {get}
    
    var parseFinished: finishedHandler? {get set}
    
    var manager: Alamofire.SessionManager {get set}
    
    var countriesArray: Array<AnyObject>? {get}
    
    func load(finished: @escaping finishedHandler)
    
    func getResult() -> NSArray
    
    func parseResult(result: NSArray)
}

extension Context {
    
    //MARK: Accessors
    
    var countriesArray: Array<AnyObject>?  {
        return Country.mr_findAllSorted(by: "name", ascending: true)
    }
    
    //MARK: Public Methods
    
    mutating func load(finished: @escaping finishedHandler) {
        self.parseFinished = finished
        
        self.parseResult(result: self.getResult().lastObject as! NSArray)
    }
    
    func cancel() {
        self.manager.request(self.URLString).cancel()
    }
    
    //MARK: Private Methods
    func getResult() -> NSArray {
        var resultArray = NSArray()
        self.manager.request(self.URLString).responseJSON(completionHandler: { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            if let result: NSArray = (response.result.value as! NSArray?) {
                resultArray = result
            }
        })
        
        return resultArray
    }
    
    
}

