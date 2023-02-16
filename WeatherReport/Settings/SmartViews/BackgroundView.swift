//
//  BackgroundView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/16/23.
//

import UIKit


final class BackgroundView: UIView {
    
    
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cloudImage1: UIImage = UIImage(named: "cloud1")!
    let cloudImage2: UIImage = UIImage(named: "cloud2")!
    let cloudImage3: UIImage = UIImage(named: "cloud3")!
    
    private lazy var cloudImageView1: UIImageView = {
        let image = cloudImage1
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 531.4, height: 58.1)
        view.image = UIImage(named: "cloud1")!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cloudImageView2: UIImageView = {
        let image = cloudImage2
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cloudImageView3: UIImageView = {
        let image = cloudImage3
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cloud1XConstraint: NSLayoutConstraint!
 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
  
    
    func setupView() {

        self.addSubview(mainView)
        
        let cloud1XConstraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor)
        
        self.mainView.addSubview(cloudImageView1)
        
        
        NSLayoutConstraint.activate([
            
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.cloudImageView1.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 37),
            cloud1XConstraint
       
        ])
    }
    
    func moveClouds() {
        NSLayoutConstraint.deactivate([
            self.cloud1XConstraint
        ])
        
        var newCloud1Constraint: NSLayoutConstraint
        
        if self.cloud1XConstraint.constant == 100 {
            newCloud1Constraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor)
        }
        else {
            newCloud1Constraint = cloudImageView1.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor, constant: 100)
        }
        
        NSLayoutConstraint.activate([
            newCloud1Constraint
        ])
        
        UIView.animate(withDuration: 0.5) {
            self.mainView.layoutIfNeeded()
            self.cloud1XConstraint = newCloud1Constraint
        }

    }

}
