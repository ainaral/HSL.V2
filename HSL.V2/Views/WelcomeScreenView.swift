//
//  WelcomeScreenView.swift
//  HSL.V2
//
//  Created by Yana Krylova on 17.4.2023.
//

import SwiftUI
import UserNotifications

struct WelcomeScreenView: View  {
    @StateObject private var model = WelcomeScreenModel()
    // User input variables
    @State private var name = ""
    private let roles: [String] = [
        "Passenger",
        "Driver"
    ]
    @State private var selectedRole: String = ""
    @State private var notifications = false
    @State private var userRole = "Passenger"
    @State private var termsAccepted = false
    @State private var isNotificationEnabled = false
    @State private var enableLocation = false

    
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
                    Picker(selection: $userRole, label: Text("")) {
                        Text("Passenger").tag("Passenger")
                        Text("Driver").tag("Driver")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                
                // Location toggle
                VStack(alignment: .leading) {
                    Toggle(isOn: $enableLocation) {
                        Text("Allow access to your location")
                            .font(.headline)
                    }
                }
                .onAppear {
                    model.requestLocationAuthorization()
                }
                .padding(.top, 30)
                .padding(.horizontal, 50)
                .foregroundColor(.white)
                
                // Notification toggle
                VStack {
                    Toggle(isOn: $isNotificationEnabled) {
                        Text("Enable Notifications")
                    }
                }
                .onAppear {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                        if granted {
                            self.isNotificationEnabled = true
                        } else {
                            self.isNotificationEnabled = false
                        }
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
                NavigationLink(destination: Group {
                    if userRole == "Passenger" {
                        PassengerView()
                    } else {
                        DriverView()
                    }
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
            .background(Color.blue)
        }
    }
}
    
struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
