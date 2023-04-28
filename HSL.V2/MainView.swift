//
//  ContentView.swift
//  HSL.V2
//
//  Created by iosdev on 27.3.2023.
//

import SwiftUI

extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool ) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

struct MainView: View {
    
    @State private var selectedRole: String = "Passenger"
    @State public var userRole: String = ""
    
    var body: some View {
        if UserDefaults.standard.welcomeScreenShown {
            TabView {
                HomeView(selectedRole: userRole)
                    .tabItem(){
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .navigationBarHidden(true)
                
                SpeechRecognizerView()
                    .tabItem(){
                        Image(systemName: "mic")
                        Text("Mic")
                    }
                
                SettingsView(roleSelected: { role in
                    userRole = role
                })
                .tabItem(){
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
            }
            .accentColor(.blue)
        } else {
            NavigationView {
                WelcomeScreenView()
//                TabView {
//                    HomeView(selectedRole: selectedRole)
//                        .tabItem(){
//                            Image(systemName: "house.fill")
//                            Text("Home")
//                        }
//                        .navigationBarHidden(true)
//
//                    SpeechRecognizerView()
//                        .tabItem(){
//                            Image(systemName: "mic")
//                            Text("Mic")
//                        }
//
//                    SettingsView(roleSelected: { role in
//                        selectedRole = role
//                    })
//                    .tabItem(){
//                        Image(systemName: "gearshape")
//                        Text("Settings")
//                    }
                }
                .accentColor(.blue)
            }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
