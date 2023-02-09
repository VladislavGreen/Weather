//
//  HourTableViewCell.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/6/23.
//

import UIKit

class HourTableViewCell: UITableViewCell {
    
    struct HourViewModel {
        let dateText: String
        let hourText: String
        let tempText: String
        let feelsLike: String
        let wind: String
        let precStrength: String
        let cloudness: String
    }
    
    private lazy var  dateLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 79, height: 22)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "пт 16/04",
            attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hourLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 47, height: 19)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "12:00",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  tempLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 20, height: 22)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "12", attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var feelsLikeImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  feelsLikeLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 270, height: 19)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "По ощущению ",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  feelsLikeValueLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 76, height: 19)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "10°",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var windImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  windLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 50, height: 19)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "Ветер",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  windValueLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 76, height: 19)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "2 m/s CCЗ",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var precipitationImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  precipitationLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 158, height: 19)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "Атмосферные осадки",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  precipitationValueLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 76, height: 16)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.96
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "0%",
            attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var cloudnessImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  cloudnessLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 128, height: 16)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.96
        view.attributedText = NSMutableAttributedString(
            string: "Облачность",
            attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  cloudnessValueLabel: UILabel = {
        let view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 76, height: 16)
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.96
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "29%",
            attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var customSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = nil
        self.hourLabel.text = nil
        self.tempLabel.text = nil
        self.feelsLikeValueLabel.text = nil
        self.windValueLabel.text = nil
        self.precipitationValueLabel.text = nil
        self.cloudnessValueLabel.text = nil
    }
    
    func setupValues(with viewModel: HourViewModel) {
        self.dateLabel.text = viewModel.dateText
        self.hourLabel.text = viewModel.hourText
        self.tempLabel.text = viewModel.tempText
        self.feelsLikeValueLabel.text = viewModel.feelsLike
        self.windValueLabel.text = viewModel.wind
        self.precipitationValueLabel.text = viewModel.precStrength
        self.cloudnessValueLabel.text = viewModel.cloudness
    }
    
    func setupView() {
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.hourLabel)
        self.contentView.addSubview(self.tempLabel)
        self.contentView.addSubview(self.feelsLikeLabel)
        self.contentView.addSubview(self.feelsLikeImageView)
        self.contentView.addSubview(self.feelsLikeValueLabel)
        self.contentView.addSubview(self.windLabel)
        self.contentView.addSubview(self.windImageView)
        self.contentView.addSubview(self.windValueLabel)
        self.contentView.addSubview(self.precipitationLabel)
        self.contentView.addSubview(self.precipitationImageView)
        self.contentView.addSubview(self.precipitationValueLabel)
        self.contentView.addSubview(self.cloudnessLabel)
        self.contentView.addSubview(self.cloudnessImageView)
        self.contentView.addSubview(self.cloudnessValueLabel)
        self.contentView.addSubview(self.customSeparator)
        
        NSLayoutConstraint.activate([
            
            self.contentView.heightAnchor.constraint(equalToConstant: 145),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.hourLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
            self.hourLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.tempLabel.topAnchor.constraint(equalTo: self.hourLabel.bottomAnchor, constant: 10),
            self.tempLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 22),
            
            self.feelsLikeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
            self.feelsLikeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 90),
            
            self.feelsLikeImageView.centerYAnchor.constraint(equalTo: self.feelsLikeLabel.centerYAnchor),
            self.feelsLikeImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 74),
            self.feelsLikeImageView.widthAnchor.constraint(equalToConstant: 16),
            self.feelsLikeImageView.heightAnchor.constraint(equalToConstant: 16),
            
            self.feelsLikeValueLabel.centerYAnchor.constraint(equalTo: self.feelsLikeLabel.centerYAnchor),
            self.feelsLikeValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            self.windLabel.topAnchor.constraint(equalTo: self.feelsLikeLabel.bottomAnchor, constant: 8),
            self.windLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 90),
            
            self.windImageView.centerYAnchor.constraint(equalTo: self.windLabel.centerYAnchor),
            self.windImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 74),
            self.windImageView.widthAnchor.constraint(equalToConstant: 16),
            self.windImageView.heightAnchor.constraint(equalToConstant: 16),
            
            self.windValueLabel.centerYAnchor.constraint(equalTo: self.windLabel.centerYAnchor),
            self.windValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            self.precipitationLabel.topAnchor.constraint(equalTo: self.windLabel.bottomAnchor, constant: 8),
            self.precipitationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 90),
            
            self.precipitationImageView.centerYAnchor.constraint(equalTo: self.precipitationLabel.centerYAnchor),
            self.precipitationImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 74),
            self.precipitationImageView.widthAnchor.constraint(equalToConstant: 16),
            self.precipitationImageView.heightAnchor.constraint(equalToConstant: 16),
            
            self.precipitationValueLabel.centerYAnchor.constraint(equalTo: self.precipitationLabel.centerYAnchor),
            self.precipitationValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            self.cloudnessLabel.topAnchor.constraint(equalTo: self.precipitationLabel.bottomAnchor, constant: 8),
            self.cloudnessLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 90),
            
            self.cloudnessImageView.centerYAnchor.constraint(equalTo: self.cloudnessLabel.centerYAnchor),
            self.cloudnessImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 74),
            self.cloudnessImageView.widthAnchor.constraint(equalToConstant: 16),
            self.cloudnessImageView.heightAnchor.constraint(equalToConstant: 16),
            
            self.cloudnessValueLabel.centerYAnchor.constraint(equalTo: self.cloudnessLabel.centerYAnchor),
            self.cloudnessValueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            
            self.customSeparator.topAnchor.constraint(equalTo: self.cloudnessLabel.bottomAnchor, constant: 8),
            self.customSeparator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.customSeparator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            self.customSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            self.customSeparator.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1)
        ])
    }
}
