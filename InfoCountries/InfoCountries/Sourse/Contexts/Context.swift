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
    
    var URLString: String = String()

    var contextFinished: contextFinishedBlock?
        
    var sessionConfig: URLSessionConfiguration?
    
    var manager: Alamofire.SessionManager?

    //MARK: - Initializations and Deallocation
    
    init(urlString: String, finished: @escaping contextFinishedBlock) { //rmove urlString
        self.URLString = urlString
        self.contextFinished = finished
    }
    
    deinit {
        self.cancel()
    }
    
    //MARK: - Public Methods
    
    func load() {
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
                self?.parse(result: result)
            }
        })

    }
    
    func cancel() {
        self.manager?.request(self.URLString).cancel()
    }
    
    //MARK: - Private Methods
    
    func parse(result: NSArray) {
        
    }
    
   func setupSessionConfig() {
        self.sessionConfig = URLSessionConfiguration.background(withIdentifier:self.URLString)
        self.manager = Alamofire.SessionManager(configuration: self.sessionConfig!)
    }
    
}


