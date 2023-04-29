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
    
    @StateObject var settingsModel = SettingsViewModel()
    //@ObservableObject var settingsManager = SettingsManager.shared
    @State public var userRole: String = ""
    
    var body: some View {
        if UserDefaults.standard.welcomeScreenShown {
            TabView {
                HomeView()
                //HomeView(settingsModel: settingsModel)
                    .tabItem(){
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
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
            }
        }
    }
  
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeScreenView()
        }
    }
}
