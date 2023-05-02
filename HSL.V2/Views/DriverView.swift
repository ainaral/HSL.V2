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
    var mapView = MKMapView()
    
    var body: some View {
        NavigationStack {
            ZStack {
                mapLayer
                // .ignoresSafeArea()
                .edgesIgnoringSafeArea(.top)
                VStack {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding()
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}

extension DriverView {
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .accentColor(Color(.systemPink))
            .onAppear {
//                viewModel.setLocationOnMap(mapView: mapView)
                viewModel.checkIfLocationServicesIsEnabled()
            }
//            .onChange(of: viewModel.currentLocation) { _ in
//                viewModel.setLocationOnMap(mapView: mapView)
//            }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct SearchBarView: View {
    
    @Binding var searchText: String
    @ObservedObject private var viewModel = DriverViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .opacity(searchText.isEmpty ? 1.0 : 0.0)
                    .foregroundColor(Color.theme.blue)
                TextField(NSLocalizedString("SearchBusNum", comment: ""), text: $searchText)
                    .disableAutocorrection(true)
                    .onChange(of: searchText) { searchText in
                        viewModel.searchText = searchText
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .offset(x: 10)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                .foregroundColor(Color.theme.blue)
                                .onTapGesture {
                                    viewModel.fetchData(queryType: .busesByNumber(search: searchText))
                                }
                            //                                    .alert(isPresented: $viewModel.showAlert) {
                            //                                        Alert(title: Text("No bus"), message: Text("Please check your bus"), dismissButton: .default(Text("OK")))
                            //                                    }
                            
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .offset(x: 10)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                .foregroundColor(Color.theme.blue)
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
                        NavigationLink(
                            bus.shortName,
                            destination:
                                MapView(busName: bus.shortName, selectedBus: bus.shortName)
                                .ignoresSafeArea()
                        )
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
}

