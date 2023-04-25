//
//  PassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
import MapKit
/*
// Define a struct for a City object with an id, name, and coordinates
struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

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
*/

struct PassengerView: View {
    
    @StateObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                mapLayer
                    .ignoresSafeArea()
                
                VStack {
                    searchBus(searchText: $viewModel.searchText)
                        .padding()
                    Spacer()
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

struct searchBus: View {
    @Binding var searchText: String
    @ObservedObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .opacity(searchText.isEmpty ? 1.0 : 0.0)
            
            TextField("Search by your bus number...", text: $searchText)
                .disableAutocorrection(true)
                .onChange(of: searchText) { searchText in
                    viewModel.searchText = searchText
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .offset(x: 10)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                viewModel.fetchData(queryType: .busesByNumber(search: searchText))
                            }
                        
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchText = ""
                                viewModel.showBusList = false
                            }
                    }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(
                    color: Color.black.opacity(0.8),
                    radius: 10, x: 0, y:0)
        )
        .padding(.horizontal)
        
        if viewModel.showBusList {
            if let buses = viewModel.buses as [Bus]? {
                List(buses, id: \.gtfsId) { bus in
                    Button {
                        viewModel.fetchData(queryType: .routeByBus(search: bus.shortName))
                        viewModel.showBusList = false
                        viewModel.showDirectionList = true
                    } label: {
                        Text(bus.shortName)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        
        if viewModel.showDirectionList {
            if let patternArray = viewModel.patternArray as [Pattern]? {
                List(patternArray, id: \.name) { item in
                    NavigationLink(
                        item.name,
                        destination:
                            MapViewPassenger(
                                patternGeometry: item.patternGeometry.points,
                                stopsInfo: viewModel.stops)
                            .ignoresSafeArea()
                    )
                }
                .listStyle(PlainListStyle())
                .padding()
            }
        }
    }
}
