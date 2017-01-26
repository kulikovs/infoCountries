//
//  UIStoryboard+Extensions.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 1/23/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T:UIViewController> (controllerType: T.Type) -> T {
        let viewController = instantiateViewController(withIdentifier: String(describing: controllerType)) as! T
        
        return viewController
    }
    
}
