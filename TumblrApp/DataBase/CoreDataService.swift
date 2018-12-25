//
//  CoreDataService.swift
//  TumblrApp
//
//  Created by Alex on 23.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import CoreData


final class CoreDataService {
    
    static let shared = CoreDataService()
    
    //MARK: Core Data Stack
    
    lazy var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: CoreDataService.self).url(forResource: "TumblrApp",
                                                             withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("TumblrApp")
        let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    //MARK: Core Data Saving support
    
    func saveContext () {
        if CoreDataService.shared.managedObjectContext.hasChanges {
            do {
                try CoreDataService.shared.managedObjectContext.save()
            } catch {
                abort()
            }
        }
    }
    
    //MARK: Core Data Methods
    
    func fetchData<T: NSManagedObject>(entity: T.Type,
                                       predicateFormat: String? = nil,
                                       sortDescriptorKey: String? = nil) -> [T]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        
        if let predicateFormat = predicateFormat {
            fetchRequest.predicate = NSPredicate(format: predicateFormat)
        }
        
        if let sortDescriptorKey = sortDescriptorKey {
            fetchRequest.sortDescriptors = [ NSSortDescriptor(key: sortDescriptorKey, ascending: false)]
        }
        
        do {
            let result = try CoreDataService.shared.managedObjectContext.fetch(fetchRequest)
            
            return result.count > 0 ? result as? [T] : nil
        } catch {
            return nil
        }
    }
    
    func deleteAllRecords<T: NSManagedObject>(entity: T.Type) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try CoreDataService.shared.managedObjectContext.execute(deleteRequest)
            try  CoreDataService.shared.managedObjectContext.save()
        } catch {
        }
    }
    
    func delete(_ object: NSManagedObject) {
        CoreDataService.shared.managedObjectContext.delete(object)
        do {
            try  CoreDataService.shared.managedObjectContext.save()
        } catch {
        }
    }
}
