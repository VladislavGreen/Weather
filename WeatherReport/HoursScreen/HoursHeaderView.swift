//
//  HoursHeaderView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/6/23.
//

import UIKit
import SwiftUI

class HoursHeaderView: UITableViewHeaderFooterView {
    
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "City, Country",
            attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainView : UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainView)
        contentView.addSubview(separatorView)

        
        NSLayoutConstraint.activate([
            
            self.contentView.heightAnchor.constraint(equalToConstant: 209),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 48),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.mainView.heightAnchor.constraint(equalToConstant: 152),
            self.mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.mainView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            
            self.separatorView.heightAnchor.constraint(equalToConstant: 20),
            self.separatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.separatorView.topAnchor.constraint(equalTo: self.mainView.bottomAnchor),
        ])
    }
    
    func setupValues(title: String) {
        titleLabel.text = title
    }
    
    func setupCharts(with data: [ChartViewModel]) {
        var swiftUIView = HoursChartsSwiftUIView()
        swiftUIView.data = data
        let hostingController = UIHostingController(rootView: swiftUIView.frame(height: 156).edgesIgnoringSafeArea(.all))
        hostingController.view.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(hostingController.view)

        let constraints = [
            hostingController.view.topAnchor.constraint(equalTo: mainView.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            mainView.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
