//
//  DetailsCountryViewController.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit
import RxSwift

class DetailsCountryViewController: UIViewController, ViewControllerRootView {
    
    typealias RootViewType = DetailsCountryView
    
    var disposeBag = DisposeBag()
    
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
            
            self.context?.load().subscribe(onNext: { country in
                rootView.fillWith(model: country)
                rootView.reloadInputViews()
                self.loadingView?.hideLoadingView()
            }, onError: {error in
                print(error)
                self.loadingView?.hideLoadingView()
            }, onCompleted: {
                print(RxSwift.completeString)
            },onDisposed: {
                print(RxSwift.disposedString)
            }).addDisposableTo(disposeBag)
        }
    }
    
}
