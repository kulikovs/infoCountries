//
//  UITableView+Extensions.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 2/1/17.
//  Copyright © 2017 Sergey Kulikov. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeueReusableCellWith<T: UITableViewCell>(cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("Сell \(identifier) not found")
        }
        
        return cell
    }
    
}
