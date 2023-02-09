//
//  DaysHeaderView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/7/23.
//

import UIKit


class DaysHeaderView: UITableViewHeaderFooterView {
    
    
    private lazy var mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        label.attributedText = NSMutableAttributedString(
            string: "Ежедневный прогноз",
            attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(mainView)
        mainView.addSubview(label)
        
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalToConstant: 56),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),

            label.heightAnchor.constraint(equalToConstant: 22),
            label.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            label.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10)
        ])
    }
}
