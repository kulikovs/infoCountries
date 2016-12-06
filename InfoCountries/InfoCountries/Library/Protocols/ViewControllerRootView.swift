//
//  ViewControllerRootView.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/22/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerRootView {

    associatedtype RootViewType
    
    var rootView: RootViewType { get }
}

    
public extension ViewControllerRootView where Self : UIViewController {
    var rootView: RootViewType {
        return self.view as! RootViewType
    }
    
}
