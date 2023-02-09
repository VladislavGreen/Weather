//
//  Alerts.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/30/23.
//

import UIKit


class Alerts {
    
    static let defaultAlert = Alerts()
    
    func showOkAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(actionOK)
        
        if var topController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}
