//
//  UserSettings.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/2/23.
//

import Foundation

class SettingsManager {
    
    static let shared = SettingsManager()
    
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}
