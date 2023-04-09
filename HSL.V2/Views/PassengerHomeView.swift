//
//  PassengerHomeView.swift
//  HSL.V2
//
//  Created by iosdev on 9.4.2023.
//

import SwiftUI
import MapKit

// Define a struct for a City object with an id, name, and coordinates
struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Define the PassangerView which contains a MapView
struct PassangerHomeView: View {
    
    // State variable to toggle the search screen
    @State var showSearchScreen: Bool = false
    
    // State variable for the region displayed in the MapView
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 64.5124616, longitude: 16.925641), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    
    // An array of City objects to display as annotations on the MapView
    let annotations = [
        City(name: "Helsinki", coordinate: CLLocationCoordinate2D(latitude: 60.167109, longitude: 24.9330739)),
        City(name: "Espoo", coordinate: CLLocationCoordinate2D(latitude: 60.2043106, longitude: 24.6544416)),
    ]
    
    // The body of the PassangerView, which displays a MapView
    var body: some View {
        // A ZStack to layer the MapView and the search screen button on top of each other
        ZStack(alignment: .bottom){
            
            // A GeometryReader to size the MapView
            GeometryReader { geometry in
                
                // The MapView displaying the annotations and the region
                Map(coordinateRegion: $region, annotationItems: annotations) {
                    MapMarker(coordinate: $0.coordinate)
                }
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                // .edgesIgnoringSafeArea(.bottom)
            }
            // A VStack to hold the search screen button
            VStack{
                Button("Press me") {
                    showSearchScreen.toggle()
                }
                .font(.largeTitle)
            }
            // A ZStack to hold the search screen
            ZStack{
                // Show the search screen if showSearchScreen is true
                if showSearchScreen {
                    // The search screen with text fields for origin, destination, and bus stops
                    searchScreen(showSearchScreen: $showSearchScreen)
                        .cornerRadius(30)
                        .padding(.top, 90)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
            .zIndex(2.0)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// A struct for the search screen, which includes text fields for origin, destination, and bus stops
struct searchScreen: View{
    // The `showSearchScreen` property is a binding that indicates whether the search screen should be shown or hidden.
    @Binding var showSearchScreen: Bool
    
    // The number of stops the passanger needs to be notified before the bus arrives
    enum BusStops: String, Codable, CaseIterable {
        case stopOne = "One Stop"
        case stopTwo = "Two Stops"
        case stopThree = "Three Stops"
    }
    
    @State var busNum: String = ""
    @State private var originLocation: String = ""
    @State private var destinationLocation: String = ""
    @State private var busStops: BusStops = .stopOne
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Search for bus number")) {
                    TextField("Search here", text: $busNum)
                }
                Section(header: Text("Origin Location")) {
                    TextField("Origin", text: $originLocation)
                }
                Section(header: Text("Destination Location")) {
                    TextField("Destination", text: $destinationLocation)
                }
                List {
                    Picker(selection: $busStops) {
                        ForEach(BusStops.allCases, id: \.self){ stop in
                            Text(stop.rawValue.capitalized).tag(stop)
                        }
                    } label: {
                        Text("Select stops to be notified")
                            .font(.custom("Georgia", size: 18, relativeTo: .title))
                    }
                    .pickerStyle(.menu)
                }
            }
            // The `Spacer` view expands to fill any remaining vertical space in the layout.
            Spacer()
            
            // The `Button` view allows the user to close the search screen.
            Button(action: {
                showSearchScreen.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}
    
    
struct PassengerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        //searchScreen(showSearchScreen: .constant(true))
        PassangerHomeView()
    }
}

