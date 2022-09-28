//
//  Item1+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA071 on 9/27/22.
//
//

import Foundation
import CoreData


extension Item1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item1> {
        return NSFetchRequest<Item1>(entityName: "Item1")
    }

    @NSManaged public var emailID: String?
    @NSManaged public var describe: String?
    @NSManaged public var title: String?
    @NSManaged public var image: String?

}
