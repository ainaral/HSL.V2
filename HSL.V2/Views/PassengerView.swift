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
    
    @State private var showSearchView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                mapLayer
                    .edgesIgnoringSafeArea(.top)
                
                if showSearchView {
                    SearchPassengerView(showSearchView: .constant(true))
                } else {
                    PassengerSearchActivationView()
                        .padding(.top, 630)
                        .onTapGesture {
                            showSearchView.toggle()
                        }
                }
                
                PassengerActionButton(showSearchView: $showSearchView)
                    .padding(.leading)
                    .padding(.top, 4)
            
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
