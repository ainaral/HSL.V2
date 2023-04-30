//
//  HomeView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var settingsModel: SettingsViewModel
    
    var body: some View {
        VStack{
            if settingsModel.selectedRole == "Passenger" {
                ZStack{
                    PassengerView()
                }
            }
            else if settingsModel.selectedRole == "Driver" {
                ZStack{
                    DriverView()
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
            let settingsModel = SettingsViewModel()
            return HomeView(settingsModel: settingsModel)
        }
    }
    

