//
//  SettingsView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    
    // Reference to managed object context
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    // Data for the information
    @FetchRequest(entity: UserPreferences.entity(), sortDescriptors: [], animation: .default)
    var userPreferences: FetchedResults<UserPreferences>
    
    // save data to the core data
    func saveUserPreferences() throws{
        let newUserPreference = UserPreferences(context: context)
        newUserPreference.fullName = fullName
        newUserPreference.role = selectedRole
        newUserPreference.language = selectedLanguage
        
        do {
            try context.save()
            print("User preferences saved.")
        } catch {
            print("Error saving user preferences: \(error.localizedDescription)")
            throw error
        }

    }
    
    func fetchUserPreferences(){
        // Fetch the data from core data
        do{
            let userPreferences = try context.fetch(UserPreferences.fetchRequest())
            if let preferences = userPreferences.first {
                selectedRole = preferences.role ?? ""
                selectedLanguage = preferences.language ?? ""
            }
        } catch {
            print("Error fetching user preferences: \(error.localizedDescription)")
        }
    }
    
    private let roles: [String] = [
        "Passenger",
        "Driver"
    ]
    @State private var selectedRole: String = ""
    
    private let languages: [String] = [
        "English",
        "Finnish",
        "Swedish"
    ]
    @State private var selectedLanguage: String = ""
    @State private var fullName = ""
    @State private var sendNotifications = false
    @State private var location = false
    // @State private var aboutUs = ""
    
    var roleSelected: ((String) -> Void)? // callback function
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("My information")){
                    TextField("Full Name", text: $fullName)
                    HStack {
                        Picker("I am a", selection: $selectedRole) {
                            ForEach(roles, id: \.self) { role in
                                Text(role)
                            }
                        }
                        .onChange(of: selectedRole) { value in
                            roleSelected?(value) // call the callback function when role is selected
                        }
                        .foregroundColor(Color.theme.blue)
                    }
                    HStack {
                        Picker("Choose a language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language)
                                    .tag(language)
                            }
                        }
                        .foregroundColor(Color.theme.blue)
                    }
                    
                }
                Section(header:Text ("Notifications")){
                    Toggle("Notifications", isOn: $sendNotifications)
                        .foregroundColor(Color.theme.blue)
                }
                Section(header:Text ("Location Permission")){
                    Toggle("Location", isOn: $location)
                        .foregroundColor(Color.theme.blue)
                }
                Section(header:Text ("About us")){
                    NavigationLink(destination: AboutUsView()) {
                        Label("About us", systemImage: "person.3.fill")
                            .font(.headline)
                            .foregroundColor(Color.theme.blue)
                    }
                }
                Section {
                    Button(action: {
                        do {
                            try saveUserPreferences()
                        } catch {
                            print("Error saving user preferences: \(error.localizedDescription)")
                        }                    }) {
                            Text("Save")
                        }
                }
                
                .navigationTitle("Settings")
            }
            
            
            
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
}
