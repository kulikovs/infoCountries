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
    
    var loadingView = LoadingView.loadingView()
    
    var countryName: String? {
        didSet {
        self.context = CountryDetailContext(countryName: countryName!)
        }
    }
    
    var context : CountryDetailContext? {
        willSet {
            self.context?.cancel()
        }
        didSet {
            let rootView = self.rootView
            self.loadingView?.showLoadingViewOn(view: self.rootView, animated: false)
            
            self.context?.load().then { country -> Void in
                rootView.fillWith(model: country)
                rootView.reloadInputViews()
                self.loadingView?.hideLoadingView()
                }
                .always {
                    self.loadingView?.hideLoadingView()
                }
                .catch(execute: { error in
                    print(error)
                })
        }
    }
    
}
