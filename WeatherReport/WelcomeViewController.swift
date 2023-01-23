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
        
        // TEMPORARILY
//        vc = OnboardingViewController()
        vc = PageViewController()
        
        //        if SettingsManager.shared.isFirstLaunch {
        //            vc = OnboardingViewController()
        //            SettingsManager.shared.isFirstLaunch = true
        //        } else {
        //            vc = PageViewController()
        //        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
