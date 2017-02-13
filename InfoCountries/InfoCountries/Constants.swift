//
//  Constants.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 12/6/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation

    //MARK: - Context

struct Context {
    struct Request {
        static let countriesURLString  = "http://api.worldbank.org/country?"
        static let countryURLString    = "https://restcountries.eu/rest/v1/name/"
    }
    struct Parse {
        static let nameKey         = "name"
        static let capitalKey      = "capital"
        static let pagesKey        = "pages"
        static let populationKey   = "population"
        static let numericCodeKey  = "numericCode"
        static let callingCodesKey = "callingCodes"
        static let longitudeKey    = "longitude"
        static let latitudeKey     = "latitude"
    }
}

    //MARK: - Paging

struct Paging {
    static let baseCurrentPage = 0
    static let baseTotalPages  = 1
    static let basePerPage     = 12
}

struct RxSwift {
    static let disposedString    = "observer - on disposed"
    static let completeString    = "observer - on complete"
    static let cancelledString   = "request - cancelled"
}
