//
//  WelcomeScreenModel.swift
//  HSL.V2
//
//  Created by Yana Krylova on 20.4.2023.
//

import Foundation
import CoreLocation
import Combine
//import CoreData
//import SwiftUI

class WelcomeScreenModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    private var cancellable: AnyCancellable?
    static let isFirstLaunchKey = "isFirstLaunch"
    //@Published var fullName = ""
    //@Published var selectedRole: String = ""
    //@Published var selectedLanguage: String = ""
    //@Published var sendNotifications = false
    //@Published var location = false
    @Published var enableLocation = false
    
   /* // Reference to managed object context
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    // Data for the information
    @FetchRequest(entity: UserPreferences.entity(), sortDescriptors: [], animation: .default)
    var userPreferences: FetchedResults<UserPreferences> {
        didSet {
            fetchUserPreferences()
        }
    }
*/
    override init() {
        super.init()
        locationManager.delegate = self
        //fetchUserPreferences()
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableLocation = status == .authorizedWhenInUse
    }
    /*
    // save data to the core data
    func saveUserPreferences() throws{
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        // Fetch the existing user preferences
        let request = NSFetchRequest<UserPreferences>(entityName: "UserPreferences")
        let existingPreferences = try context.fetch(request).first
        
        if let preferences = existingPreferences {
            // Update the existing entity with the new information
            preferences.fullName = fullName
            preferences.role = selectedRole
            preferences.language = selectedLanguage
            preferences.location = location
            preferences.notications = sendNotifications
        } else {
            // Create a new entity with the new information
            let newPreferences = UserPreferences(context: context)
            newPreferences.fullName = fullName
            newPreferences.role = selectedRole
            newPreferences.language = selectedLanguage
            newPreferences.location = location
            newPreferences.notications = sendNotifications
        }
        
        do {
            try context.save()
            print("User preferences saved.")
        } catch {
            print("Error saving user preferences: \(error.localizedDescription)")
            throw error
        }
        
        // Fetch the updated preferences from Core Data and update the UI
        do {
            let updatedPreferences = try context.fetch(request).first
            if let preferences = updatedPreferences {
                fullName = preferences.fullName ?? ""
                selectedRole = preferences.role ?? ""
                selectedLanguage = preferences.language ?? ""
                location = preferences.location
                sendNotifications = preferences.notications
                //sendNotifications = preferences.sendNotifications
                //location = preferences.location
            }
        } catch {
            print("Error fetching user preferences: \(error.localizedDescription)")
        }
    }
    
    func fetchUserPreferences(){
        // Fetch the data from core data
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        do{
            let userPreferences = try context.fetch(request)
            if let preferences = userPreferences.first {
                fullName = preferences.fullName ?? ""
                selectedRole = preferences.role ?? ""
                selectedLanguage = preferences.language ?? ""
                location = preferences.location
                sendNotifications = preferences.notications
                print("Full Name: \(preferences.fullName ?? "")")
                print("Role: \(preferences.role ?? "")")
                print("Language: \(preferences.language ?? "")")
                print("Location: \(preferences.location)")
                print("Notifications: \(preferences.notications)")
            } else {
                let newUserPreference = UserPreferences(context: context)
                newUserPreference.fullName = fullName
                newUserPreference.role = selectedRole
                newUserPreference.language = selectedLanguage
                newUserPreference.location = location
                newUserPreference.notications = sendNotifications
                try context.save()
            }
        } catch {
            print("Error fetching user preferences: \(error.localizedDescription)")
        }
    }
    internal let roles: [String] = ["Passenger", "Driver"]
    internal let languages: [String] = ["English","Finnish","Swedish"]
    
    func deleteUserPreferences() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserPreferences.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            print("User preferences deleted.")
        } catch {
            print("Error deleting user preferences: \(error.localizedDescription)")
            throw error
        }
    }*/
}
