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
        ZStack {
            mapLayer
                .ignoresSafeArea()

            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                    .padding()
                Spacer()
            }
        }
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
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct SearchBarView: View {
    
    @Binding var searchText: String
    @StateObject private var viewModel = DriverViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("      Search by your bus number...", text: $searchText)
                    .disableAutocorrection(true)
                    .onChange(of: searchText) { searchText in
                        viewModel.searchText = searchText
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .opacity(searchText.isEmpty ? 1.0 : 0.0)
                            
                            Spacer()
                            
                            Image(systemName: "magnifyingglass")
                                .offset(x: 10)
                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                .onTapGesture {
                                    viewModel.fetchBusesByNumber(search: searchText)
                                    viewModel.showBusList.toggle()
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
//                guard let buses = viewModel.buses else {
                if let buses = viewModel.buses as [Bus]? {
                    List(buses, id: \.gtfsId) { bus in
                        Button {
                            viewModel.fetchRouteByBus(search: bus.shortName)
                        } label: {
                            Text(bus.shortName)
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
}
