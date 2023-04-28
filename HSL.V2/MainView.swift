//
//  ContentView.swift
//  HSL.V2
//
//  Created by iosdev on 27.3.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedRole: String = "Passenger"
    
    var body: some View {
        TabView {
            HomeView(selectedRole: selectedRole)
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            
            SpeechRecognizerView()
                .tabItem(){
                    Image(systemName: "mic")
                    Text("Mic")
                }
            
            SettingsView(roleSelected: { role in
                selectedRole = role
            })
            .tabItem(){
                Image(systemName: "gearshape")
                Text("Settings")
                    .foregroundColor(Color.theme.blue)
            }
        }
        .background(Color.theme.background)
        .accentColor(Color.theme.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

/*
 // Fetch the user preference from Core Data
 let request: NSFetchRequest<UserPreference> = UserPreference.fetchRequest()
 let preferences = try? context.fetch(request)

 // Check the user preference and load the appropriate view
 if let userPreference = preferences?.first {
     if userPreference.role == "driver" {
         performSegue(withIdentifier: "showDriverView", sender: self)
     } else if userPreference.role == "passenger" {
         performSegue(withIdentifier: "showPassengerView", sender: self)
     }
 }

 */
