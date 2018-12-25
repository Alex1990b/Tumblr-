//
//  Post+CoreDataClass.swift
//  
//
//  Created by Alex on 23.12.18.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject, Decodable, TableViewDataSource {
    
    var didDeletePost: ((Post) -> ())?
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Post", in: context) else { fatalError() }
        
   
        self.init(entity: entity, insertInto: context)
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let newId = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        var isPostFavorite: Bool?
        
        if let posts = CoreDataService.shared.fetchData(entity: Post.self, predicateFormat: "id == \(newId)"),
            let oldPost = posts.first {
            isPostFavorite = oldPost.isFavorite
            posts.forEach  {
                didDeletePost?($0)
                CoreDataService.shared.delete($0)
            }
        }
        
        
        blogName  = try container.decodeIfPresent(String.self, forKey: .blogName)
        id        = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        date      = try container.decodeIfPresent(String.self, forKey: .date)
        postUrl   = try container.decodeIfPresent(String.self, forKey: .postUrl)
        noteCount = try container.decodeIfPresent(Int.self, forKey: .noteCount) ?? 0
        title     = try container.decodeIfPresent(String.self, forKey: .title)
        linkImage = try container.decodeIfPresent(String.self, forKey: .linkImage)
        publisher = try container.decodeIfPresent(String.self, forKey: .publisher)
        tags      = try container.decodeIfPresent(Array.self, forKey: .tags)
        blog      = try container.decodeIfPresent(Blog.self, forKey: .blog)
        
        isFavorite = isPostFavorite ?? false
        CoreDataService.shared.saveContext()
    }
    
    enum CodingKeys: String, CodingKey {
        
        case blogName  = "blog_name"
        case id        = "id"
        case date      = "date"
        case postUrl   = "post_url"
        case summary   = "summary"
        case noteCount = "note_count"
        case title     = "title"
        case linkImage = "link_image"
        case publisher = "publisher"
        case tags      = "tags"
        case blog      = "blog"
    }
}
