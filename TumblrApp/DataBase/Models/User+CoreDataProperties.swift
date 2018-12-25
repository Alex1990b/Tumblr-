//
//  User+CoreDataProperties.swift
//  
//
//  Created by Alex on 24.12.18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var likes: Int
    @NSManaged public var name: String?
    @NSManaged public var following: Int
}
