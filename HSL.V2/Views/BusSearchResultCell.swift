//
//  BusSearchResultCell.swift
//  HSL.V2
//
//  Created by iosdev on 23.4.2023.
//

import SwiftUI
struct BusSearchResultCell: View {
    let title: String
    let subTitle: String
    
    
    // This view displays the bus search results
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.body)
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}
struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        BusSearchResultCell(title: "532", subTitle: "Leppavaara")
    }
}


