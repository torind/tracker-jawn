//
//  CoreDataManager.swift
//  Tracker Jawn
//
//  Created by Torin on 5/17/17.
//  Copyright © 2017 Torin. All rights reserved.
//

import CoreData

final class CoreDataManager {
    let modelName : String
    
    private(set) lazy var managedObjectContext : NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel : NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to find data model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load data model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentDirectoryURL = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask)[0]
        
        let persistentStoreURL = documentDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType : NSSQLiteStoreType,
                                                              configurationName : nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to load persistent store")
        }
        return persistentStoreCoordinator
    }()
    
    init (modelName : String) {
        self.modelName = modelName
        setupNotificationHandling()
    }
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationWillTerminate, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func saveChanges(_ notification: Notification) {
        saveChanges()
    }
    
    private func saveChanges() {
        print("Saving changes")
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to save managed object context")
            print("\(error), \(error.localizedDescription)")
        }
    }
}
