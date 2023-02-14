//
//  DaupartRowView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/13/23.
//

import UIKit


final class DaypartRowView: UIView {
    
   
    struct DaypartRowViewModel {
        var picImage: UIImage
        var titleLabelText: String
        var valueText: String
    }
    
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var picImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "termometerSun")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "По ощущениям ",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "11°",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
        self.mainView.addSubview(titleLabel)
        self.mainView.addSubview(picImageView)

        self.mainView.addSubview(valueLabel)
        self.mainView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 13),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor,constant: 54),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 19),
            
            self.picImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.picImageView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor,constant: 16),
            self.picImageView.heightAnchor.constraint(equalToConstant: 20),
            self.picImageView.widthAnchor.constraint(equalToConstant: 20),
            
            self.valueLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.valueLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.valueLabel.heightAnchor.constraint(equalToConstant: 22),

            self.separatorView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 14),
            self.separatorView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.separatorView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.separatorView.heightAnchor.constraint(equalToConstant: 1),
            self.separatorView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
        ])
    }
    
    func setupValues(with viewModel: DaypartRowViewModel) {
        
        titleLabel.text = viewModel.titleLabelText
        picImageView.image = viewModel.picImage
        valueLabel.text = viewModel.valueText
    }
}
