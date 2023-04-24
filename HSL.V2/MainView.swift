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
            }
        }
        .accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
    }
}
