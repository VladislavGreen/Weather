//
//  DaypartView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/11/23.
//

import UIKit


final class DaypartView: UIView {
    
   
    struct DaypartViewModel {
        var daypart: String
        var temp: String
        var precStrength: Float
        var condition: String
    }
    
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var daypartTitleLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 43, height: 22)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "День",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let centerGroupView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var precStrengthImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        var view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 32, height: 36)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 30)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        view.attributedText = NSMutableAttributedString(
            string: "13",
            attributes: [NSAttributedString.Key.kern: 0.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let conditionLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
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
  
    
    private func setupView() {

        self.addSubview(mainView)
        self.mainView.addSubview(daypartTitleLabel)
        self.mainView.addSubview(centerGroupView)
            self.centerGroupView.addSubview(precStrengthImageView)
            self.centerGroupView.addSubview(tempLabel)
        self.mainView.addSubview(conditionLabel)
        
        NSLayoutConstraint.activate([
            
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.daypartTitleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 21),
            self.daypartTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor,constant: 15),
            self.daypartTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            
            self.centerGroupView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 15),
            self.centerGroupView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            self.centerGroupView.heightAnchor.constraint(equalToConstant: 36),
            self.centerGroupView.widthAnchor.constraint(equalTo: self.tempLabel.widthAnchor, constant: 48),
            
            self.precStrengthImageView.topAnchor.constraint(equalTo: self.centerGroupView.topAnchor),
            self.precStrengthImageView.leadingAnchor.constraint(equalTo: self.centerGroupView.leadingAnchor),
            self.precStrengthImageView.heightAnchor.constraint(equalToConstant: 36),
            self.precStrengthImageView.widthAnchor.constraint(equalToConstant: 36),
                        
            self.tempLabel.topAnchor.constraint(equalTo: self.centerGroupView.topAnchor),
            self.tempLabel.leadingAnchor.constraint(equalTo: self.precStrengthImageView.trailingAnchor, constant: 12),
            self.tempLabel.heightAnchor.constraint(equalToConstant: 36),
            
            self.conditionLabel.topAnchor.constraint(equalTo: self.tempLabel.bottomAnchor, constant: 11),
            self.conditionLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            self.conditionLabel.heightAnchor.constraint(equalToConstant: 22),
            
        ])
    }
    
    func setupValues(with viewModel: DaypartViewModel) {

        daypartTitleLabel.text = viewModel.daypart
        tempLabel.text = viewModel.temp
        precStrengthImageView.image = DataConverters.shared.getPrecStrengthPicture(byPrecStrength: viewModel.precStrength)
        conditionLabel.text = DataConverters.shared.getConditionDescription(byString: viewModel.condition)
    }
}
