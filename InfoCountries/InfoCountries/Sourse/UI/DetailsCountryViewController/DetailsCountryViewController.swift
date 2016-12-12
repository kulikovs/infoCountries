//
//  DetailsCountryViewController.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import UIKit

class DetailsCountryViewController: UIViewController, ViewControllerRootView {
    
    typealias RootViewType = DetailsCountryView
    
    //MARK: - Accessors
    
    var pandingModel : PagingModel? {
        didSet {
            self.pandingModel?.pagingFinished = self.update()
            self.pandingModel?.getCountryInfo()
        }
    }
    
   //MARK: - Private methods
    
    fileprivate func update() -> (pagingFinishedBlock) {
        
        return { [weak self] (_ model: AnyObject) -> Void in
            self?.rootView.fillWith(model: model as! Country)
            self?.rootView.reloadInputViews()
        }
    }
    
}
