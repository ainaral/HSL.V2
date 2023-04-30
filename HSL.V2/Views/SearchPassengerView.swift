//
//  SearchPassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct SearchPassengerView: View {
    // The `showSearchScreen` property is a binding that indicates whether the search screen should be shown or hidden.
    @Binding var showSearchView: Bool
    
    @StateObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom){
            if showSearchView {
                // Show the search screen if showSearchScreen is true
                VStack {
                    searchBus(searchText: $viewModel.searchText)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
    
}
struct searchBus: View {
    @Binding var searchText: String
    @ObservedObject private var viewModel = PassengerViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .opacity(searchText.isEmpty ? 1.0 : 0.0)
                    .foregroundColor(Color.theme.blue)
                TextField("Search by your bus number...", text: $searchText)
                    .disableAutocorrection(true)
                    .frame(height: 45)
                    .background(Color(.systemGroupedBackground))
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
            .padding(.horizontal)
            .padding(.top, 64)
            Spacer()
            
            Divider()
                .padding(.vertical)
            
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
        .background(Color.theme.background)
        
    }
}
struct SearchPassengerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPassengerView(showSearchView: .constant(true))
    }
}
