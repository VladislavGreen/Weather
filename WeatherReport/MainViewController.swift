//
//  MainViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/5/23.
//

import UIKit

class MainViewController: UIViewController {
    
    var recentLocation: String = ""
    
    private var labelFirst: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_SemiBold", size: 16)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.11
        // Line height: 21 pt
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Посмотреть страну из CoreData", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Light_Medium", size: 12)
        button.addTarget(self, action: #selector(tempButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelFirst.text = recentLocation
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = recentLocation
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tablecells"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "tablecells"))
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(labelFirst)
        view.addSubview(tempButton)
        
        NSLayoutConstraint.activate([
           
            labelFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            labelFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            labelFirst.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            
            tempButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            tempButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            tempButton.topAnchor.constraint(equalTo: labelFirst.bottomAnchor, constant: 40)
        ])
    }
    
    @objc
    func tempButtonPressed() {
        let newWeather = CoreDataManager.dafaultManager.getCoreDataCash()
        labelFirst.text = newWeather?.geoCountryName
        
    }
}
