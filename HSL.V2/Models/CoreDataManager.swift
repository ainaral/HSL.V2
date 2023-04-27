//
//  CoreDataManager.swift
//  HSL.V2
//
//  Created by 张嬴 on 24.4.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "HSLModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
/*    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // save user preferences
    func saveContext () {
        if  managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }*/

    // to save the data
    func save() {
        do {
            try viewContext.save()
            print("saved")
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    // to get all markers
    func getMarkers() -> [Marker] {
        let request: NSFetchRequest<Marker> = Marker.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
             return []
        }
    }
    
    // only get the marker by name
    func getMarkersByBus(busName: String) -> [Marker] {
        let request: NSFetchRequest<Marker> = Marker.fetchRequest()
        request.predicate = NSPredicate(format: "busName == %@", busName)
        do {
            let markers = try viewContext.fetch(request)
            return markers
        } catch {
            print("Error fetching markers: \(error)")
            return []
        }
    }
}
