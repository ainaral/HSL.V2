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
    
    // State variable to toggle the search screen
    @State var showSearchScreen: Bool = true
    
    // State variable for the region displayed in the MapView
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.172783, longitude: 24.9362295), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    // An array of City objects to display as annotations on the MapView
    let annotations = [
        City(name: "Helsinki", coordinate: CLLocationCoordinate2D(latitude: 60.167109, longitude: 24.9330739)),
        City(name: "Espoo", coordinate: CLLocationCoordinate2D(latitude: 60.2043106, longitude: 24.6544416)),
    ]
    
    // The body of the PassangerView, which displays a MapView
    var body: some View {
        // A ZStack to layer the MapView and the search screen on top of each other
        ZStack(alignment: .bottom){
            
            // A GeometryReader to size the MapView
            GeometryReader { geometry in
                
                // The MapView displaying the annotations and the region
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapMarker(coordinate: $0.coordinate)
                }
                .ignoresSafeArea()
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            // The search screen displayed as a pop-up
            SearchPassengerView(showSearchScreen: $showSearchScreen)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
        .onAppear {
            showSearchScreen = true
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
                        viewModel.selectedBus = bus.shortName
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
                                stopsInfo: viewModel.stops,
                                selectedBus: viewModel.selectedBus)
                            .ignoresSafeArea()
                            
                    )
                }
                .listStyle(PlainListStyle())
                .padding()
            }
        }
    }
}
