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
import SwiftyJSON

let httpMethodGet = "GET"
let countriesURLString = "http://api.worldbank.org/country?per_page=10&format=json&page=1"

class CountriesContext: NSObject {
    
    //MARK: Public Methods
    
    func load() {
        Alamofire.request(countriesURLString).responseJSON(completionHandler: { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            if let result: NSArray = response.result.value as! NSArray? {
                self.parseResult(result: result.lastObject as! NSArray)
            }
        })
    }
    
        //MARK: Private Methods
    
    func parseResult(result: NSArray) {
        let resultArray = JSON(result)
        
        for country in resultArray.array! {
            var countries = [AnyObject]()
     //       var model = TestModel()
      //      model.name = country["name"].stringValue as NSString?
      //      countries.append(model)
            //  print(model.name! as NSString)
            
            //save model
        }
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


