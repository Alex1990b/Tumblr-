//
//  User+CoreDataClass.swift
//  
//
//  Created by Alex on 24.12.18.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {
  
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { fatalError() }
        
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name       = try container.decodeIfPresent(String.self, forKey: .name)
        likes      = try container.decodeIfPresent(Int.self, forKey: .likes) ?? 0
        following  = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name      = "name"
        case likes     = "likes"
        case following = "following"
    }
}
