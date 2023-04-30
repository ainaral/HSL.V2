//
//  HomeView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var settingsModel: SettingsViewModel
    var updatedRole: String = ""
    
    var body: some View {
        VStack{
            if settingsModel.selectedRole == "Passenger" {
                ZStack{
                    PassengerView()
                    Text(settingsModel.selectedRole)
                    
                }
            }
            else if settingsModel.selectedRole == "Driver" {
                ZStack{
                    DriverView()
                    Text(settingsModel.selectedRole)
                    
                }
            }
        }
        .onAppear{
            settingsModel.fetchUserPreferences()
        }
        
    }
    
}
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            //HomeView()
            let settingsModel = SettingsViewModel()
            //settingsModel.selectedRole = "Passenger"
            //settingsModel.fetchUserPreferences()
            return HomeView(settingsModel: settingsModel, updatedRole: "")
        }
    }
    

