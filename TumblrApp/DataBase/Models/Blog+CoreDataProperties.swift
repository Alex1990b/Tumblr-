//
//  Blog+CoreDataProperties.swift
//  
//
//  Created by Alex on 23.12.18.
//
//

import Foundation
import CoreData


extension Blog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Blog> {
        return NSFetchRequest<Blog>(entityName: "Blog")
    }

    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var post: Post?

}
