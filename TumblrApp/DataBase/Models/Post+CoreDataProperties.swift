//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Alex on 23.12.18.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var blogName: String?
    @NSManaged public var id: Int
    @NSManaged public var date: String?
    @NSManaged public var postUrl: String?
    @NSManaged public var summary: String?
    @NSManaged public var noteCount: Int
    @NSManaged public var title: String?
    @NSManaged public var linkImage: String?
    @NSManaged public var publisher: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var blog: Blog?
    @NSManaged public var isFavorite: Bool
}
