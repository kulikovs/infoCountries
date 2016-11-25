//
//  Country+CoreDataProperties.swift
//  InfoCountries
//
//  Created by Sergey Kulikov on 11/23/16.
//  Copyright © 2016 Sergey Kulikov. All rights reserved.
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country");
    }

    @NSManaged public var callingCode: Int16
    @NSManaged public var capital: String?
    @NSManaged public var name: String?
    @NSManaged public var numericCode: Int16
    @NSManaged public var population: Int64
}
