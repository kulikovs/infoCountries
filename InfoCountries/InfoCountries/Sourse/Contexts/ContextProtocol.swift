//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/1/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MagicalRecord

//public protocol ContextProtocol: class {
    
//    typealias finishedHandler = (AnyObject) -> Void
//    
//    var URLString: String {get set}
//    
//    var parseFinished: finishedHandler? {get set}
//    
//    var manager: Alamofire.SessionManager {get set}
//    
//    func load(finished: @escaping finishedHandler)
//    
//    func parseResult(result: NSArray)
//    
//    func cancel()
//    
//}
//
//extension Context {
//    
//    //MARK: Public Methods
//    
//    func load(finished: @escaping finishedHandler) {
//        self.parseFinished = finished
//        
//        self.manager.request(self.URLString).responseJSON(completionHandler: {[weak self] response in
//            if let status = response.response?.statusCode {
//                switch(status){
//                case 201:
//                    print("example success")
//                default:
//                    print("error with response status: \(status)")
//                }
//            }
//            if let result: NSArray = (response.result.value as! NSArray?) {
//                self?.parseResult(result: result)
//            }
//        })
//        
//    }
//    
//    func cancel() {
//        self.manager.request(self.URLString).cancel()
//    }
//    
//}

