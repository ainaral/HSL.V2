//
//  Colors.swift
//  HSL.V2
//
//  Created by iosdev on 24.4.2023.
//

import Foundation

import Foundation
import  SwiftUI

extension Color{
    static let theme = ColorTheme()
    
    
}

// To access the colors -> Color.theme.accent
struct ColorTheme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let blue = Color("Blue")
    let celestailBlue = Color("CelestialBlue")
    let frenchBlue = Color("FrenchBlue")
    let gray = Color("Gray")
    let lightBlue = Color("LightBlue")
    let moreLightBlue = Color("MoreLightBlue")
    let steelBlue = Color("SteelBlue")
    let tuftsBlue = Color("TuftsBlue")
}
