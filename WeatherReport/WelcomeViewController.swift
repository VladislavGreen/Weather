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
        let vc: UIViewController
        
        // TEMP
        vc = OnboardingViewController()
        
        //        if SettingsManager.shared.isFirstLaunch {
        //            vc = OnboardingViewController()
        //            SettingsManager.shared.isFirstLaunch = true
        //        } else {
        //            vc = MainViewController()
        //        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
