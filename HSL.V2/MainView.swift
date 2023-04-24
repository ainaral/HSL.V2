//
//  ContentView.swift
//  HSL.V2
//
//  Created by iosdev on 27.3.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            
            MicView()
                .tabItem(){
                    Image(systemName: "mic")
                    Text("Mic")
                }
            
            SettingsView()
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
