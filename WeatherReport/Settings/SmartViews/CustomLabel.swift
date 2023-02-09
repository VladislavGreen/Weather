//
//  SmartViews.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/24/23.
//

import UIKit


final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        self.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
        self.attributedText = NSMutableAttributedString(string: "Название", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
