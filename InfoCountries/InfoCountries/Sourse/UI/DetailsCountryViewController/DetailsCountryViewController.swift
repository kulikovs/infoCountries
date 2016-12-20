//
//  DetailsCountryViewController.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import PromiseKit

class DetailsCountryViewController: UIViewController, ViewControllerRootView {
    
    typealias RootViewType = DetailsCountryView
    
//    var promiseContext: CountryContext?
    var promiseCountry: Promise<Country>?
    
    //MARK: - Accessors
    
    deinit {
        print("DetailsCountryViewController deinit")
    }
    
    var context : CountryDetailContext? {
        willSet {
//            self.context?.cancel()
        }
        didSet {
            self.context?.load().then { country -> Void in
                self.rootView.fillWith(model: country as! Country)
                self.rootView.reloadInputViews()
                }.catch(execute: { err in
                    print(err)
                })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let promise = load(country: "Andorra").then(execute: {[weak self] country->Void in
//            print(country)
//            print("finish")
//            self?.rootView.fillWith(model: country)
//            self?.rootView.reloadInputViews()
//        })
        
    }
    
}
