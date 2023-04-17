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
                // VStack to test if the fetchAPI works, later will remove
                /*VStack {
                        if let routes = viewModel.items {
                        List(routes, id: \.gtfsId) { route in
                            Text("gtfsIs: \(route.gtfsId)")
                            Text("shortName: \(route.shortName)")
                            Text("longName: \(route.longName)")
                            Text("stop: \(route.trips[0].stoptimes[0].stop.name)")
                            Text("stop: \(route.trips[0].stoptimes[0].realtimeArrival)")
                            Text("stop: \(route.trips[1].stoptimes[0].stop.name)")
                            Text("stop: \(route.trips[1].stoptimes[0].realtimeArrival)")
                        }
                    } else {
                        Text("Loading")
                    }
                }.onAppear {
                    self.viewModel.fetchStop()
            }*/
            }
        }
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}

