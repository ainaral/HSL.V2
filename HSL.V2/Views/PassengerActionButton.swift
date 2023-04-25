//
//  PassengerActionButton.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI
struct PassengerActionButton: View {
    
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
    
}
struct PassengerActionButton_Previews: PreviewProvider {
    static var previews: some View {
        PassengerActionButton(showSearchView: .constant(true))
    }
}

