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

struct SearchBus: View {
    @Binding var searchText: String
    @ObservedObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .opacity(searchText.isEmpty ? 1.0 : 0.0)
            
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
