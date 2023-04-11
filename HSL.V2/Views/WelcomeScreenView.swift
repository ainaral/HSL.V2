//
//  WelcomeScreenView.swift
//  HSL.V2
//
//  Created by Yana Krylova on 11.4.2023.
//

import SwiftUI

struct WelcomeScreen: View {
    
    // User input variables
    @State private var name = ""
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
    @State private var location = false
    @State private var notifications = false
    @State private var signInAs = "Passenger"
    @State private var language = "English"
    @State private var locationEnabled = false
    @State private var termsAccepted = false
    @State private var notificationEnabled = false
    
    var body: some View {
        VStack {
            // Header
            Text("Welcome to HSL.V2")
                .font(.largeTitle)
                .bold()
                .padding(.top, 100)
                .foregroundColor(.white)
            Text("Let's get started")
                .font(.subheadline)
                .foregroundColor(.black)
            
            // Sign in as dropdown
            VStack(alignment: .leading) {
                Text("Sign in as")
                    .font(.headline)
                Picker(selection: $signInAs, label: Text("")) {
                    Text("Passenger").tag("Passenger")
                    Text("Driver").tag("Driver")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top, 30)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
            
            // Language dropdown
            VStack(alignment: .leading) {
                Text("Choose the language")
                    .font(.headline)
                Picker(selection: $language, label: Text("")) {
                    Text("English").tag("English")
                    Text("Finnish").tag("Finnish")
                    Text("Swedish").tag("Swedish")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.top, 30)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
            
            // Location toggle
            VStack(alignment: .leading) {
                Toggle(isOn: $locationEnabled) {
                    Text("Allow access to your location")
                        .font(.headline)
                }
            }
            
            .padding(.top, 30)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
            
            // Notification toggle
            VStack(alignment: .leading) {
                Toggle(isOn: $notificationEnabled) {
                    Text("Allow notifications")
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
            
            // Continue button
            NavigationLink(destination: HomeView()) {
                Text("Continue")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
            }
            .disabled(!termsAccepted)
            .opacity(termsAccepted ? 1.0 : 0.5)
        }
   .background(Color.blue.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}

