//
//  DriverView.swift
//  HSL.V2
//
//  Created by 张嬴 on 6.4.2023.
//

import SwiftUI
import MapKit

struct DriverView: View {

    @StateObject private var viewModel = DriverViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .ignoresSafeArea()
                    .accentColor(Color(.systemPink))
                    .onAppear {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
            }
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}

