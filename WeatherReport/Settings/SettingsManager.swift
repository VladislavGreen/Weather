//
//  UserSettings.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/2/23.
//

import Foundation

class SettingsManager {
    
    static let shared = SettingsManager()
    
    private let defaults = UserDefaults.standard
    
    var isFirstLaunch: Bool {
        set {
            defaults.setValue(newValue, forKey: #function)
        }
        get {
            !defaults.bool(forKey: #function)
        }
        
    }
    
    var isCelsius: Bool {
        set {
            defaults.setValue(newValue, forKey: "isCelcius")
        }
        get {
            return defaults.bool(forKey: "isCelcius")
        }
    }
    
    var isKilometers: Bool {
        set {
            defaults.setValue(newValue, forKey: "isKilometers")
        }
        get {
            return defaults.bool(forKey: "isKilometers")
        }
    }
    
    var is24hours: Bool {
        set {
            defaults.setValue(newValue, forKey: "is24hours")
        }
        get {
            return defaults.bool(forKey: "is24hours")
        }
    }
    
    var notificationIsEnabled: Bool {
        set {
            defaults.setValue(newValue, forKey: "notificationIsEnabled")
        }
        get {
            return defaults.bool(forKey: "notificationIsEnabled")
        }
    }
}
