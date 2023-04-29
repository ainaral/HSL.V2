//
//  SettingsManager.swift
//  HSL.V2
//
//  Created by iosdev on 28.4.2023.
//

import Foundation

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    @Published var settingsModel = SettingsViewModel()
    var roleSelected: ((String) -> Void)?
}
