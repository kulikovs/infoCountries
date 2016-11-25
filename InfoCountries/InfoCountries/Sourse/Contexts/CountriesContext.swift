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

let httpMethodGet = "GET"
let countriesURLString = "http://api.worldbank.org/country?per_page=10&format=json&page=1"

class CountriesContext: NSObject {
    
    var dataTask : URLSessionDataTask?
    
    func parseResult(result: NSArray) {
        
    }
    
    func prepareToLoad() {
//        Alamofire.request(countriesURLString).responseJSON { response in
//            if let json: NSArray = response.result.value as! NSArray? {
//                print("JSON: \(json)")
//                var model = TestModel(JSONString: "")
//                
//            }
//        }
      
        Alamofire.request(countriesURLString).responseData(completionHandler: { data in
            
            
        })

     //   let request = NSMutableURLRequest.init(url: NSURL(string: countriesURLString)! as URL)
//        let session = URLSession.shared
//        self.dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            do {
//                if (error != nil) {
//                } else {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
//                    self.parseResult(result: jsonData)
//                }
//            }
//            catch {
//                
//            }
//        })
//        
//        self.dataTask?.resume()
        
    
    }
}
