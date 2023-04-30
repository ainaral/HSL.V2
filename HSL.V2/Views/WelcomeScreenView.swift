//
//  WelcomeScreenView.swift
//  HSL.V2
//
//  Created by Yana Krylova on 17.4.2023.
//

import SwiftUI
import UserNotifications

struct WelcomeScreenView: View {
    
    @StateObject private var settingsModel = SettingsViewModel()
    @StateObject private var welcomeModel = WelcomeScreenModel()
    
    @State private var termsAccepted = false
    @State private var showMainView = false

    var roleSelected: ((String) -> Void)? // callback function
    
    init(roleSelected: ((String) -> Void)? = nil) {
        self.roleSelected = roleSelected
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Welcome to HSL.V2")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 100)
                    .foregroundColor(.white)
                
                // Sign in as dropdown
                VStack(alignment: .leading) {
                    Text("Sign in as")
                        .font(.headline)
                    Picker(selection: $settingsModel.selectedRole, label: Text("")) {
                        Text("Passenger").tag("Passenger")
                        Text("Driver").tag("Driver")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .onAppear {
                    settingsModel.selectedRole = "Passenger"
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                // Location toggle
                VStack(alignment: .leading) {
                    Toggle(isOn: $settingsModel.location) {
                        Text("Allow access to your location")
                            .font(.headline)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                // Notification toggle
                VStack {
                    Toggle(isOn: $settingsModel.sendNotifications) {
                        Text("Enable Notifications")
                            .font(.headline)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                // Terms and conditions checkbox
                VStack(alignment: .leading) {
                    Toggle(isOn: $termsAccepted) {
                        Text("I accept the Terms and Conditions")
                            .font(.headline)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                Spacer()
                
                // Continue button
                Button(action: {
                    do {
                        // Call the method to save the user's preferences
                        try settingsModel.saveUserPreferences()
                        self.termsAccepted = true
                    } catch {
                        print("Error saving user preferences: \(error.localizedDescription)")
                    }
                    self.showMainView = true
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .disabled(!termsAccepted)
                .opacity(termsAccepted ? 1.0 : 0.5)
                .padding(.top, 30)
                .fullScreenCover(isPresented: $showMainView) {
                    MainView(userRole: settingsModel.selectedRole)
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
            .background(Color.blue)
        }
        .onAppear(perform: {
            UserDefaults.standard.welcomeScreenShown = true
        })
    }
    
    struct WelcomeScreenView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeScreenView()
        }
    }
}
