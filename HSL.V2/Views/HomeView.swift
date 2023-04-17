//
//  HomeView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct HomeView: View {
    let selectedRole: String
    
    var body: some View {
        if selectedRole == "Passenger" {
            PassengerView()
        } else if selectedRole == "Driver" {
            DriverView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedRole: "Passenger")
    }
}
