//
//  WelcomeViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/3/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var vc: UIViewController
        
        if SettingsManager.shared.isFirstLaunch {
            
            SettingsManager.shared.isCelsius = true
            SettingsManager.shared.isKilometers = true
            SettingsManager.shared.is24hours = true
            SettingsManager.shared.notificationIsEnabled = true
            
            SettingsManager.shared.isFirstLaunch = true
            
            vc = OnboardingViewController()
            
        } else {
            updateCoreDataValues()
            vc = PageViewController()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func updateCoreDataValues() {
//    (completion: ()->()) {
        let weathers = CoreDataManager.defaultManager.getCoreDataCash()
        guard weathers?.count != 0 else { return }

        for weather in weathers! {
            guard
                let lat = weather.info?.lat,
                let lon = weather.info?.lon,
                let locationName = weather.cityName
            else {
                return
            }
            downloadWeatherInfo(lat: lat, lon: lon) { weather, errorString in

                guard weather != nil else {
                    print("Данные о погоде не приходят")
                    Alerts.defaultAlert.showOkAlert(
                        title: "Не можем получить данные",
                        message: "Проверьте соединение")
                    return
                }

                CoreDataManager.defaultManager.setCoreDataCash(weather: weather!, locationName: locationName ) {
//                    DispatchQueue.main.async {
//                        let vc = PageViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
            }
        }
    }
    
}
