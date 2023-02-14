//
//  CustomDayButton.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/14/23.
//

import UIKit

final class CustomDayButton: UIButton {
    
    var buttonAction: () -> Void = {}
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 88, height: 36)
        self.setTitle("Title", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        
//        self.layer.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        self.layer.cornerRadius = 5
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped () {
        buttonAction()
    }
}
