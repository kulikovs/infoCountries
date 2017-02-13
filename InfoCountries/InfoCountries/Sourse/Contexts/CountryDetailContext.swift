//
//  CountryDetailContext.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/7/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import MagicalRecord
import SwiftyJSON
import RxSwift

final class CountryDetailContext: ContextProtocol {

    typealias ResultType = Country
    
    let countryName: String
    
    var observer: AnyObserver<ResultType>?
    
    internal var dataTask: URLSessionDataTask?
    
    var requestString: String {
        get {
            let urlString = Context.Request.countryURLString + self.countryName
            return urlString.addingPercentEncodingForUrlQuery()!
        }
    }
    
    //MARK: - Initializations and deallocations
    
    init(countryName: String) {
        self.countryName = countryName
    }
    
    // MARK: - Initializations and deallocations
    
    deinit {
        self.cancel()
    }

    // MARK: - Public methods
    
    func parse(result: Array<Any>, observer: AnyObserver<ResultType>) {
        var countryModel: Country?
        MagicalRecord.save({ [weak self] context in
            guard let selfRef = self else {
                observer.onError(RxError.unknown)
                
                return
            }
            let resultArray = JSON(result)
            for country in resultArray.arrayValue {
                countryModel = Country.mr_findFirst(byAttribute:Context.Parse.nameKey,
                                                    withValue: selfRef.countryName,
                                                    in: context)
                countryModel?.capital = country[Context.Parse.capitalKey].string
                countryModel?.population = country[Context.Parse.populationKey].int64Value
                countryModel?.numericCode = country[Context.Parse.numericCodeKey].int16Value
                if let callingCode = country[Context.Parse.callingCodesKey].array?.first?.stringValue {
                    countryModel?.callingCode = Int16(callingCode)!
                }
            }
            }, completion: { (success, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    countryModel = countryModel?.mr_(in: NSManagedObjectContext.mr_default())
                    if countryModel != nil {
                        observer.onNext(countryModel!)
                        observer.onCompleted()
                    } else {
                        observer.onError(RxError.unknown)
                    }
                }
        })
    }
    
}
