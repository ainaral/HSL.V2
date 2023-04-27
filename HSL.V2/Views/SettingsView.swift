//
//  SettingsView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    
    /*@State private var selectedLanguage: String = ""
     @State private var fullName = ""
     @State private var sendNotifications = false
     @State private var location = false
     
     // Reference to managed object context
     let context = CoreDataManager.shared.persistentContainer.viewContext
     
     // Data for the information
     var items: [UserPreferences]?
     /*@FetchRequest(entity: UserPreferences.entity(), sortDescriptors: [], animation: .default)
      var userPreferences: FetchedResults<UserPreferences>*/
     
     // save data to the core data
     func saveUserPreferences() throws{
     let newUserPreference = UserPreferences(context: self.context)
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
     fullName = preferences.fullName ?? ""
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
     
     // @State private var aboutUs = ""
     */
    var roleSelected: ((String) -> Void)? // callback function
    
    init(roleSelected: ((String) -> Void)? = nil) {
        self.roleSelected = roleSelected
    }
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("My information")){
                    TextField("Full Name", text: $viewModel.fullName)
                    HStack {
                        Picker("I am a", selection: $viewModel.selectedRole) {
                            ForEach(viewModel.roles, id: \.self) { role in
                                Text(role)
                                    .tag(role)
                            }
                        }
                        .onChange(of: viewModel.selectedRole) { value in
                            roleSelected?(value) // call the callback function when role is selected
                        }
                        .foregroundColor(Color.theme.blue)
                    }
                    HStack {
                        Picker("Choose a language", selection: $viewModel.selectedLanguage) {
                            ForEach(viewModel.languages, id: \.self) { language in
                                Text(language)
                                    .tag(language)
                            }
                        }
                        .foregroundColor(Color.theme.blue)
                    }
                    
                }
                Section(header:Text ("Notifications")){
                    Toggle("Notifications", isOn: $viewModel.sendNotifications)
                        .foregroundColor(Color.theme.blue)
                }
                Section(header:Text ("Location Permission")){
                    Toggle("Location", isOn: $viewModel.location)
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
                            try viewModel.saveUserPreferences()
                        } catch {
                            print("Error deleting user preferences: \(error.localizedDescription)")
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
