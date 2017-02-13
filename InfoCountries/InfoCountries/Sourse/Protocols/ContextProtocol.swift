//
//  ContextProtocol.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/8/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ContextProtocol: class {
    
    associatedtype ResultType
    
    var requestString: String {get}
    
    var observer: AnyObserver<ResultType>? {get set}
    
    var dataTask: URLSessionDataTask? {get set}
    
    func load() -> Observable<ResultType>
    
    func parse(result: Array<Any>, observer: AnyObserver<ResultType>)
}

extension ContextProtocol {
    
    func load() -> Observable<ResultType>  {
        return Observable<ResultType>.create({ observer -> Disposable in
            self.observer = observer
            guard let url = URL(string: self.requestString) else {
                observer.onError(RxError.unknown)
                
                return Disposables.create()
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
                                    observer.onError(NSError.error())
                                    
                                    return
                            }
                          self?.parse(result: json, observer: observer)
                        }
                        catch {
                            observer.onError(NSError.error())
                            
                            return
                        }
                    })
                    self.dataTask?.resume()

            return Disposables.create(with: {
                self.dataTask?.cancel()
            })
        })
    }
    
    func cancel() {
        self.observer?.onError(NSError.error(with:RxSwift.cancelledString))
    }
    
}

