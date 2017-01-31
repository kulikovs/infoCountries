//
//  LoadingView.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 1/23/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

private let kLoadingAlpha:      CGFloat = 0.5
private let kRemovingAlpha:     CGFloat = 0.0
private let kDefaultDuration:   Double  = 0.5

class LoadingView: UIView {     //TODO: do not use this for subclassing
    
    @IBOutlet var spinner: UIActivityIndicatorView?
    
    var loadingView: UIView?
    
    //MARK: - Public Methods
    
    func showLoadingView() {
        showLoadingView(animated: true)
    }
    
    func showLoadingView(animated: Bool) {
        var view = self.loadingView
        if view == nil {
            view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? LoadingView
            view?.frame = self.frame
            self.loadingView = view
        }
        UIView.animate(withDuration: animated ? kDefaultDuration : 0.0,
                       animations: {
            self.loadingView?.alpha = kLoadingAlpha
            self.addSubview(view!)
        })
    }
    
    func hideLoadingView() {
        hideLoadingView(animated: true)
    }
    
    func hideLoadingView(animated: Bool) {
        UIView.animate(withDuration: animated ? kDefaultDuration : 0.0 ,
                       animations: {
                        self.loadingView?.alpha = kRemovingAlpha } ,
                       completion: { finished in
                        self.loadingView?.removeFromSuperview()
        })
    }

}
