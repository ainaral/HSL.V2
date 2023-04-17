//
//  UIApplication.swift
//  HSL.V2
//
//  Created by 张嬴 on 17.4.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
