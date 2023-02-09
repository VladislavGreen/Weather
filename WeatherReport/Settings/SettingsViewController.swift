//
//  PreferecesViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/23/23.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController {
    
    
    let tempSwitch: CustomSwitch = {
        let aSwitch = CustomSwitch()
        aSwitch.labelOff.text = "F"
        aSwitch.labelOn.text = "C"
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        return aSwitch
    }()
    
    let windSwitch: CustomSwitch = {
        let aSwitch = CustomSwitch()
        aSwitch.labelOff.text = "Mi"
        aSwitch.labelOn.text = "Km"
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        return aSwitch
    }()
    
    let timeSwitch: CustomSwitch = {
        let aSwitch = CustomSwitch()
        aSwitch.labelOff.text = "12"
        aSwitch.labelOn.text = "24"
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        return aSwitch
    }()
    
    let notifSwitch: CustomSwitch = {
        let aSwitch = CustomSwitch()
        aSwitch.labelOff.text = "Off"
        aSwitch.labelOn.text = "On"
        aSwitch.translatesAutoresizingMaskIntoConstraints = false
        return aSwitch
    }()

    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.153, green: 0.153, blue: 0.133, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.7
        view.attributedText = NSMutableAttributedString(string: "Настройки", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var setButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Установить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Light_Medium", size: 12)
        button.addTarget(self, action: #selector(setButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        //        navigationItem.hidesBackButton = true
        
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        
        let tempLabel = CustomLabel()
        tempLabel.text = "Температура"
        mainView.addSubview(tempLabel)
        
        tempSwitch.isOn = SettingsManager.shared.isCelsius
        mainView.addSubview(tempSwitch)
        
        let windLabel = CustomLabel()
        windLabel.text = "Скорость ветра"
        mainView.addSubview(windLabel)
        
        windSwitch.isOn = SettingsManager.shared.isKilometers
        mainView.addSubview(windSwitch)
        
        let timeLabel = CustomLabel()
        timeLabel.text = "Формат времени"
        mainView.addSubview(timeLabel)

        timeSwitch.isOn = SettingsManager.shared.is24hours
        mainView.addSubview(timeSwitch)
        
        let notifLabel = CustomLabel()
        notifLabel.text = "Уведомления"
        mainView.addSubview(notifLabel)
        
        notifSwitch.isOn = SettingsManager.shared.notificationIsEnabled
        mainView.addSubview(notifSwitch)
         
        mainView.addSubview(setButton)
        
        NSLayoutConstraint.activate([
        
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(equalToConstant: 320),
            mainView.heightAnchor.constraint(equalToConstant: 330),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tempLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            tempLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tempSwitch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tempSwitch.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            tempSwitch.widthAnchor.constraint(equalToConstant: 80),
            tempSwitch.heightAnchor.constraint(equalToConstant: 30),

            windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
            windLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            windLabel.heightAnchor.constraint(equalToConstant: 20),
            
            windSwitch.topAnchor.constraint(equalTo: tempSwitch.bottomAnchor, constant: 20),
            windSwitch.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            windSwitch.widthAnchor.constraint(equalToConstant: 80),
            windSwitch.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 30),
            timeLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            timeSwitch.topAnchor.constraint(equalTo: windSwitch.bottomAnchor, constant: 20),
            timeSwitch.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            timeSwitch.widthAnchor.constraint(equalToConstant: 80),
            timeSwitch.heightAnchor.constraint(equalToConstant: 30),

            notifLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            notifLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            notifLabel.heightAnchor.constraint(equalToConstant: 20),
            
            notifSwitch.topAnchor.constraint(equalTo: timeSwitch.bottomAnchor, constant: 20),
            notifSwitch.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            notifSwitch.widthAnchor.constraint(equalToConstant: 80),
            notifSwitch.heightAnchor.constraint(equalToConstant: 30),
            
            setButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            setButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            setButton.widthAnchor.constraint(equalToConstant: 250),
            setButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    
    @objc
    private func setButtonPressed() {
        print("setButtonPressed")
        
        // сохранение параметров в UserDefaults
        SettingsManager.shared.isCelsius = self.tempSwitch.isOn
        SettingsManager.shared.isKilometers = self.windSwitch.isOn
        SettingsManager.shared.is24hours = self.timeSwitch.isOn
        SettingsManager.shared.notificationIsEnabled = self.notifSwitch.isOn
        
        self.dismiss(animated: true)
    }
}
