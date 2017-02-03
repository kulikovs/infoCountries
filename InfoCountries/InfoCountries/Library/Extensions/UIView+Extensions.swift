//
//  Bundle+Extensions.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 2/1/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T? {
        let name = String(describing:self)
        guard let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? T else {
            return nil
        }
        
        return view
    }
    
}
