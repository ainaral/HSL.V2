//
//  HomeView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var settingsModel = SettingsViewModel()
    //@ObservedObject private var settingsManager = SettingsManager.shared
    //@ObservedObject var settingsManager = SettingsManager.shared
    //@EnvironmentObject var settingsModel: SettingsViewModel
    
    var body: some View {
        if settingsModel.selectedRole == "Passenger" {
            PassengerView()
        } else if settingsModel.selectedRole == "Driver" {
            DriverView()
        }
    }
}
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            //let settingsManager = SettingsManager()
            //HomeView(settingsManager: settingsManager)
            //let settingsModel = SettingsViewModel()
            //HomeView(settingsModel.selectedRole)
            HomeView()
        }
    }

