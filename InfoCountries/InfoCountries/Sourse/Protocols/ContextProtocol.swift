//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import PromiseKit

protocol ContextProtocol: class {
    
    associatedtype ResultType
    
    typealias Resolvers = (fulfill: ((ResultType)->Void), reject: ((Error)->Void))
    
    var requestString: String {get}
    
    var dataTask: URLSessionDataTask? {get set}
    
    func load() -> Promise<ResultType>
    
    func parse(result: Array<Any>, resolve: Resolvers)
}

extension ContextProtocol {
    
    func download(resolvers: Resolvers) {
        guard let url = URL(string: self.requestString) else {
            resolvers.reject(NSError.error())
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        
        self.dataTask = session.dataTask(with: request, completionHandler: {
            [weak self] (data, response, error) -> Void in
            do {
                guard let data = data,
                    error == nil,
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Any>
                    else {
                        resolvers.reject(NSError.error())
                        return
                }
                self?.parse(result: json, resolve: resolvers)
            }
            catch {
                resolvers.reject(NSError.error())
            }
        })
        
        self.dataTask?.resume()
    }
    
    func cancel() {
        self.dataTask?.cancel()
    }
    
}

