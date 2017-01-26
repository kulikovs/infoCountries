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
    
    var context : CountryDetailContext? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            let rootView = self.rootView
            rootView.showLoadingView(animated: false)
            
            self.context?.load().then { country -> Void in
                rootView.fillWith(model: country)
                rootView.reloadInputViews()
                rootView.hideLoadingView()
                }.catch(execute: { err in
                    rootView.hideLoadingView()
                    print(err)
                })
        }
    }
    
}
