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
        if settingsModel.selectedRole == "Passenger" {
            PassengerView()
        } else if settingsModel.selectedRole == "Driver" {
            DriverView()
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        let settingsModel = SettingsViewModel()
        return HomeView(settingsModel: settingsModel)
    }
}

