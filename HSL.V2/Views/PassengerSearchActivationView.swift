//
//  PassengerSearchActivationView.swift
//  HSL.V2
//
//  Created by iosdev on 27.4.2023.
//
import SwiftUI

struct  PassengerSearchActivationView: View {
    var body: some View {
        
        VStack{
            HStack{
                Rectangle()
                    .fill(.black)
                    .frame(width: 8, height: 8)
                    .padding(.horizontal)
                
                Text(NSLocalizedString("SearchBusNum", comment: ""))
                    .foregroundColor(Color.theme.accent)
                
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black,radius: 6)
        )
    }
}

struct PassengerSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        PassengerSearchActivationView()
    }
}
