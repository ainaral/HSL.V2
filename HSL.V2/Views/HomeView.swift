//
//  HomeView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct HomeView: View {
    // let selectedRole: String
    @StateObject private var settingsModel = SettingsViewModel()
    
    var body: some View {
        if settingsModel.selectedRole == "Passenger" {
            PassengerView()
        } else if settingsModel.selectedRole == "Driver" {
            DriverView()
        }
    }
    init(settingsModel: SettingsViewModel) {
        self._settingsModel = StateObject(wrappedValue: settingsModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let settingsModel = SettingsViewModel()
        HomeView(settingsModel: settingsModel)
        
    }
}
