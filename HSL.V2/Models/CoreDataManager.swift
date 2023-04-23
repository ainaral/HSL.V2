//
//  CoreDataManager.swift
//  HSL.V2
//
//  Created by iosdev on 22.4.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HSL.V2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /*func saveContext(userPreferences: UserPreferences, context: NSManagedObjectContext) {
        let userPreferences = UserPreferences(context: context)
        userPreferences.fullName = userPreferences.fullName
        userPreferences.role = userPreferences.role
        userPreferences.language = userPreferences.language

        do {
            try context.save()
        } catch {
            print("Error saving route to Core Data: \(error)")
        }
    }
     */
}
