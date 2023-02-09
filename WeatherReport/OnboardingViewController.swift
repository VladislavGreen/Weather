//
//  OnboardingViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/3/23.
//

import UIKit
import CoreLocation

class OnboardingViewController: UIViewController, CLLocationManagerDelegate {
    
    var recentLocation: Weather?

    let locationManager = CLLocationManager()
    
    
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingPic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelFirst: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_SemiBold", size: 16)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        // Line height: 21 pt
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "Разрешить приложению  Weather использовать данные \nо местоположении вашего устройства ", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelSecond: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        // Line height: 18 pt
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "Чтобы получить более точные прогнозы погоды во время движения или путешествия", attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelThird: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        // Line height: 18 pt
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "Вы можете изменить свой выбор в любое время из меню приложения", attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var yesButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Light_Medium", size: 12)
        button.addTarget(self, action: #selector(yesButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var noButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.setTitleColor(UIColor(red: 0.992, green: 0.986, blue: 0.963, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        button.addTarget(self, action: #selector(noButtonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        navigationItem.hidesBackButton = true
        
        self.view.addSubview(onboardingImageView)
        self.view.addSubview(labelFirst)
        self.view.addSubview(labelSecond)
        self.view.addSubview(labelThird)
        self.view.addSubview(yesButton)
        self.view.addSubview(noButton)
        
        NSLayoutConstraint.activate([
            onboardingImageView.widthAnchor.constraint(equalToConstant: 180),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 196),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 111),
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 148),
            
            labelFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            labelFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            labelFirst.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 56),
            
            labelSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            labelSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            labelSecond.topAnchor.constraint(equalTo: labelFirst.bottomAnchor, constant: 56),
            
            labelThird.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            labelThird.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            labelThird.topAnchor.constraint(equalTo: labelSecond.bottomAnchor, constant: 14),
            
            yesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            yesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            yesButton.topAnchor.constraint(equalTo: labelThird.bottomAnchor, constant: 44),
            yesButton.heightAnchor.constraint(equalToConstant: 40),
            
            noButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: 25)
        ])
    }
    
    @objc
    private func noButtonPressed() {
        print("No Button Pressed")
        self.pushPageViewController()
    }
    
    @objc
    private func yesButtonPressed() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("unbelievable!")}
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        let lat = mostRecentLocation.coordinate.latitude
        let lon = mostRecentLocation.coordinate.longitude
        locationManager.stopUpdatingLocation()

        /*
         сначала записываем в CoreData, и из неё же показываем в UI
         */
        
        
        downloadWeatherInfo(lat: Float(lat), lon: Float(lon)) { weather, errorString in
            
            CoreDataManager.defaultManager.setCoreDataCash(weather: weather!, locationName: "Current location") {
                DispatchQueue.main.async {
                    self.pushPageViewController()
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // ALARM
        print("невозможно получить данные о текущем местоположении, проверьте соединение")
        
        recentLocation = nil
        locationManager.stopUpdatingLocation()
        self.pushPageViewController()
    }
    
    func pushPageViewController() {
        let vc = PageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
