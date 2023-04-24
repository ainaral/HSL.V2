//
//  SettingsView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct SettingsView: View {
    
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
    
    @AppStorage("firstName") private var firstName = ""
    @State private var sendNotifications = false
    @State private var location = false
    @State private var aboutUs = ""
    
    var roleSelected: ((String) -> Void)? // callback function
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("My information")){
                    TextField("Full Name", text: $firstName)
                    HStack {
                        Picker("I am a", selection: $selectedRole) {
                            ForEach(roles, id: \.self) { role in
                                Text(role)
                            }
                        }
                        .onChange(of: selectedRole) { value in
                            roleSelected?(value) // call the callback function when role is selected
                        }
                    }
                    HStack {
                        Picker("Choose a language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language)
                            }
                        }
                    }
                    
                }
                Section(header:Text ("Notifications")){
                    Toggle("Notifications", isOn: $sendNotifications)
                }
                Section(header:Text ("Location Permission")){
                    Toggle("Location", isOn: $location)
                }
                Section(header:Text ("About us")){
                    NavigationLink(destination: AboutUsView()) {
                        Label("About us", systemImage: "person.3.fill")
                            .font(.headline)
                            .foregroundColor(.accentColor)
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
