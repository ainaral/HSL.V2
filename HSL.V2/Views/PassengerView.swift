//
//  PassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import MapKit

struct PassengerView: View {
    
    @StateObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                mapLayer
                    .ignoresSafeArea()
                VStack {
                    SearchPassengerView(showSearchView: true)
                }
            }
        }
    }
}

struct PassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerView()
    }
}

extension PassengerView {
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}
