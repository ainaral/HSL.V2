//
//  PassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import MapKit

// Define the PassangerView which contains a MapView
struct PassengerView: View {
    
    @State var busNum: String = ""
    @StateObject private var viewModel = PassengerViewModel()
    
    // State variable to toggle the search screen
    @State var showSearchView: Bool = true
        
    // The body of the PassangerView, which displays a MapView
    var body: some View {
        // A ZStack to layer the MapView and the search screen on top of each other
        ZStack(alignment: .bottom){
            
            // Shows the map view
            PassengerMapRepresentable(busName: "")
                .ignoresSafeArea()
            
            // The search screen displayed as a pop-up
            SearchPassengerView(showSearchScreen: $showSearchView)
            
            //MapViewActionButton(mapState: $mapState)
            MapViewActionButton(showSearchView: $showSearchView)
                .padding(.leading)
                .padding(.bottom, 750)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
        .onAppear {
            showSearchView = true
        }
    }
}

struct PassengerView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerView()
    }
}
