//
//  AboutUsView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView{
            VStack{
                Text(NSLocalizedString("AboutUsInfo", comment: ""))
                    .multilineTextAlignment(.leading)
                    .frame(width: 300)
                    .foregroundColor(Color.theme.accent)
            }
            .navigationTitle("About us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AboutUsView()
        }
    }
}
