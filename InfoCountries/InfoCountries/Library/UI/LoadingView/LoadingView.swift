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

class LoadingView: UIView {
    
    @IBOutlet var spinner: UIActivityIndicatorView?
    
    class func loadingView() -> LoadingView? {
        return LoadingView.fromNib()
    }
    
    //MARK: - Public Methods
    
    func showLoadingViewOn(view: UIView, animated: Bool = true) {
        self.frame = view.frame
        UIView.animate(withDuration: animated ? kDefaultDuration : 0.0,
                       animations: {
                        self.alpha = kLoadingAlpha
                        view.addSubview(self)
        })
    }
    
    func hideLoadingView(animated: Bool = true) {
        UIView.animate(withDuration: animated ? kDefaultDuration : 0.0 ,
                       animations: {
                        self.alpha = kRemovingAlpha } ,
                       completion: { finished in
                        self.removeFromSuperview()
        })
    }

}
