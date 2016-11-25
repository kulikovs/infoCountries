//
//  CountriesContext.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/24/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

let httpMethodGet = "GET"
let countriesURLString = "http://api.worldbank.org/country?per_page=10&format=json&page=1"

class CountriesContext: NSObject {
    
    func load() {
        Alamofire.request(countriesURLString).responseJSON(completionHandler: { response in
            print(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            if let result: NSArray = response.result.value as! NSArray? {
                let array: NSArray = result.lastObject as! NSArray
                let json = JSON(array)
                
                let model = TestModel()
                let name = json["name"].stringValue as NSString?
                
            }
        })
    }
    
    func parseResult(result: NSArray) {

    }
    

}


//- (void)parseResult:(NSDictionary *)result {
//    @synchronized (self) {
//        [self removeOldEvents];
//        NSArray *array = [result valueForKeyPath:kKSItemsKey];
//        NSMutableArray *events = [NSMutableArray array];
//        
//        for (NSDictionary *dictionary in array) {
//            NSDateFormatter *dayFormatter = [NSDateFormatter dateFormatterWithFormatKey:kKSDateTimeFormatKey];
//            NSDate *endDateTime = [dayFormatter dateFromString:
//                [dictionary valueForKeyPath:kKSEndDateKey]];
//            if ([[NSDate date] currentDateIsBeforeDay:endDateTime]) {
//                NSString *ID = [dictionary valueForKey:KKSIDKey];
//                KSEvent *event = [KSEvent objectWithID:ID];
//                event.startDateTime = [dayFormatter dateFromString:
//                    [dictionary valueForKeyPath:kKSStartDateKey]];
//                event.endDateTime = endDateTime;
//                event.title = [self titleFromStartDate:event.startDateTime endDate:event.endDateTime];
//                
//                [events addObject:event];
//            }
//        }
//        
//        [self.calendar setEvents:[NSSet setWithArray:events]];
//        [self.calendar saveManagedObject];
//    }
//}


