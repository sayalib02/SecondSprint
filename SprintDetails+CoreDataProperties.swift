//
//  SprintDetails+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA071 on 9/27/22.
//
//

import Foundation
import CoreData


extension SprintDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SprintDetails> {
        return NSFetchRequest<SprintDetails>(entityName: "SprintDetails")
    }

    @NSManaged public var name: String?
    @NSManaged public var emailID: String?
    @NSManaged public var mobileNo: String?
    @NSManaged public var password: String?

}
