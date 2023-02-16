//
//  PreferecesViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/23/23.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController {
    
    private lazy var cloudImageView1: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 531.4, height: 58.1)
//        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        view.image = UIImage(named: "cloud1")!
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var cloud1XConstraint: NSLayoutConstraint!
    
    private lazy var cloudImageView2: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 531.4, height: 58.1)
        view.image = UIImage(named: "cloud2")!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var cloud2XConstraint: NSLayoutConstraint!
    
    private lazy var cloudImageView3: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 531.4, height: 58.1)
        view.image = UIImage(named: "cloud3")!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var cloud3XConstraint: NSLayoutConstraint!
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateXConstraint(object: cloudImageView1, constraintX: self.cloud1XConstraint, constantX: -256, animationDuration: 100)
        animateXConstraint(object: cloudImageView2, constraintX: self.cloud2XConstraint, constantX: -0, animationDuration: 40)
        animateXConstraint(object: cloudImageView3, constraintX: self.cloud3XConstraint, constantX: 400, animationDuration: 60)
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        
        self.view.addSubview(mainView)
        self.view.addSubview(cloudImageView1)
        self.view.addSubview(cloudImageView2)
        self.view.addSubview(cloudImageView3)
        
        let cloud1XConstraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -78)
        self.cloud1XConstraint = cloud1XConstraint
        
        let cloud2XConstraint = cloudImageView2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 274)
        self.cloud2XConstraint = cloud2XConstraint
        
        let cloud3XConstraint = cloudImageView3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100)
        self.cloud3XConstraint = cloud3XConstraint



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
            
            self.cloudImageView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 37),
            cloud1XConstraint,
            
            self.cloudImageView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            cloud2XConstraint,
            
            self.cloudImageView3.topAnchor.constraint(equalTo: view.topAnchor, constant: 652),
            cloud3XConstraint,
            
            self.mainView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 28),
            self.mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -27),
            self.mainView.heightAnchor.constraint(equalToConstant: 320),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 27),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            tempLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            tempLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.tempSwitch.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            self.tempSwitch.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -30),
            self.tempSwitch.widthAnchor.constraint(equalToConstant: 80),
            self.tempSwitch.heightAnchor.constraint(equalToConstant: 30),

            windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
            windLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            windLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.windSwitch.topAnchor.constraint(equalTo: self.tempSwitch.bottomAnchor, constant: 20),
            self.windSwitch.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -30),
            self.windSwitch.widthAnchor.constraint(equalToConstant: 80),
            self.windSwitch.heightAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 30),
            timeLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.timeSwitch.topAnchor.constraint(equalTo: self.windSwitch.bottomAnchor, constant: 20),
            self.timeSwitch.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -30),
            self.timeSwitch.widthAnchor.constraint(equalToConstant: 80),
            self.timeSwitch.heightAnchor.constraint(equalToConstant: 30),

            notifLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            notifLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 20),
            notifLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.notifSwitch.topAnchor.constraint(equalTo: self.timeSwitch.bottomAnchor, constant: 20),
            self.notifSwitch.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -30),
            self.notifSwitch.widthAnchor.constraint(equalToConstant: 80),
            self.notifSwitch.heightAnchor.constraint(equalToConstant: 30),
            
            self.setButton.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            self.setButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -16),
            self.setButton.widthAnchor.constraint(equalToConstant: 250),
            self.setButton.heightAnchor.constraint(equalToConstant: 40)
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
    
    func moveClouds() {
        NSLayoutConstraint.deactivate([
            self.cloud1XConstraint
        ])
        
        var newCloud1Constraint: NSLayoutConstraint
        
        if self.cloud1XConstraint.constant == -78 {
            newCloud1Constraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        }
        else {
            newCloud1Constraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -78)
        }
        
        NSLayoutConstraint.activate([
            newCloud1Constraint
        ])
        
        UIView.animate(
            withDuration: 2, delay: 0.1, options: [.repeat, .autoreverse]) {
                self.view.layoutIfNeeded()
                self.cloud1XConstraint = newCloud1Constraint
        }
    }
    
    private func animateXConstraint(object: UIImageView, constraintX: NSLayoutConstraint, constantX: Float, animationDuration: Double) {
        NSLayoutConstraint.deactivate([
            constraintX
        ])
        
        var newXConstraint: NSLayoutConstraint
        
        let x = CGFloat(constantX)
        
        if constraintX.constant == x {
            newXConstraint = object.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        }
        else {
            newXConstraint = object.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: x)
        }
        
        NSLayoutConstraint.activate([
            newXConstraint
        ])
        
        
        UIView.animate(
            withDuration: animationDuration, delay: 0.1, options: [.repeat, .autoreverse]) {
                
                self.view.layoutIfNeeded()
                
                if constraintX == self.cloud1XConstraint {
                    self.cloud1XConstraint = newXConstraint
                }
                if constraintX == self.cloud2XConstraint {
                    self.cloud2XConstraint = newXConstraint
                }
                if constraintX == self.cloud3XConstraint {
                    self.cloud3XConstraint = newXConstraint
                }
        }
    }
}
