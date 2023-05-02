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
                Section(header: Text(NSLocalizedString("MyInformation", comment: ""))){
                    TextField(NSLocalizedString("FullName", comment: ""), text: $firstName)
                    HStack {
                        Picker(NSLocalizedString("Iam", comment: ""), selection: $selectedRole) {
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
                        Picker(NSLocalizedString("Language", comment: ""), selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language)
                            }
                        }
                        .foregroundColor(Color.theme.blue)
                    }
                    
                }
                Section(header:Text (NSLocalizedString("Notifications", comment: ""))){
                    Toggle(NSLocalizedString("Notifications", comment: ""), isOn: $sendNotifications)
                        .foregroundColor(Color.theme.blue)
                }
                Section(header:Text (NSLocalizedString("LocationPermission", comment: ""))){
                    Toggle(NSLocalizedString("Location", comment: ""), isOn: $location)
                        .foregroundColor(Color.theme.blue)
                }
                Section(header:Text (NSLocalizedString("AboutUs", comment: ""))){
                    NavigationLink(destination: AboutUsView()) {
                        Label(NSLocalizedString("AboutUs", comment: ""), systemImage: "person.3.fill")
                            .font(.headline)
                            .foregroundColor(Color.theme.blue)
                    }
                }
                
                .navigationTitle("Settings")
            }
            .foregroundColor(Color.theme.gray)
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
}
