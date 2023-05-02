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
    
    var roleSelected: ((String) -> Void)? // callback function
    
    init(roleSelected: ((String) -> Void)? = nil) {
        self.roleSelected = roleSelected
    }
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text(NSLocalizedString("MyInformation", comment: ""))){
                    TextField(NSLocalizedString("FullName", comment: ""), text: $viewModel.fullName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)
                    HStack {
                        Picker(NSLocalizedString("Iam", comment: ""), selection: $viewModel.selectedRole) {
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
                }
                Section(header:Text (NSLocalizedString("Notifications", comment: ""))){
                    Toggle(NSLocalizedString("Notifications", comment: ""), isOn: $viewModel.sendNotifications)
                        .foregroundColor(Color.theme.blue)
                }
                
                Section(header:Text (NSLocalizedString("LocationPermission", comment: ""))){
                    Toggle(NSLocalizedString("Location", comment: ""), isOn: $viewModel.location)
                        .foregroundColor(Color.theme.blue)
                }
                
                Section(header:Text (NSLocalizedString("AboutUs", comment: ""))){
                    NavigationLink(destination: AboutUsView()) {
                        Label(NSLocalizedString("AboutUs", comment: ""), systemImage: "person.3.fill")
                            .font(.headline)
                            .foregroundColor(Color.theme.blue)
                    }
                }
                Section {
                    Button(action: {
                        
                        do {
                            try viewModel.saveUserPreferences()
                            viewModel.fetchUserPreferences()
                        } catch {
                            print("Error deleting user preferences: \(error.localizedDescription)")
                        }                    }) {
                            Text(NSLocalizedString("Save", comment: ""))
                        }
                }
                .navigationTitle("Settings")
            }
        }
        .onAppear{
            viewModel.fetchUserPreferences()
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
}
