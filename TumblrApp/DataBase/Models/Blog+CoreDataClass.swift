//
//  Blog+CoreDataClass.swift
//  
//
//  Created by Alex on 23.12.18.
//
//

import Foundation
import CoreData

@objc(Blog)
public class Blog: NSManagedObject, Decodable {
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Blog", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name  = try container.decodeIfPresent(String.self, forKey: .name)
        title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case title = "title"
    }
}
