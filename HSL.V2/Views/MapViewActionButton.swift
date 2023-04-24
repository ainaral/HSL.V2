//
//  MapViewActionButton.swift
//  HSL.V2
//
//  Created by iosdev on 18.4.2023.
//

import SwiftUI

struct MapViewActionButton: View {
    
    // @Binding var mapState: MapViewState
    @Binding var showSearchView: Bool
    
    var body: some View {
        
        Button {
            withAnimation(.spring()){
                showSearchView.toggle()
            }
        } label: {
            Image(systemName: showSearchView ? "map" : "magnifyingglass")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /*func actionForState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("DEBUG: No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "magnifyingglass"
        case .searchingForLocation, .locationSelected:
            return "xmark"
        }
        
    }*/
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        //MapViewActionButton(mapState: .constant(.noInput))
        MapViewActionButton(showSearchView: .constant(true))
    }
}
