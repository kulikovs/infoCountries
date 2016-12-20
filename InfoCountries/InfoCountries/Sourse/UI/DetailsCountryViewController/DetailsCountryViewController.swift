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
    
    //MARK: - Accessors
    
    var context : Context? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            self.context?.load().then { (country: Country) -> Void in
                self.rootView.fillWith(model: country)
                self.rootView.reloadInputViews()
                }.catch(execute: { err in
                    print(err)
                })
        }
    }
    
}
