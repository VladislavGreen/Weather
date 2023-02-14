//
//  sunMoonView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/13/23.
//

import UIKit


final class SunMoonAirView: UIView {
    
   
    struct SunMoonAirViewModel {
        var sunDuration: String
        var sunRise: String
        var sunSet: String
        var moonDuration: String
        var moonRise: String
        var moonSet: String
        var airQuality: String
    }

    // Тут было решено сделать все элементы впрямую
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunMoonLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "Солнце и Луна",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullMoonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "fullMoon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullMoonLabel: UILabel = {
        let view = UILabel()
//        view.backgroundColor = .red
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "Полнолуние",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "conditionClear")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunDuration: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "05:19",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "moon")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moonDuration: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "05:19",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "Восход",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moonriseLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "Восход",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunriseTimeLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "05:19",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var moonriseTimeLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "05:19",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "Заход",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var moonsetLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "Заход",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "19:46",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var moonsetTimeLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(
            string: "19:46",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var airTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "Качество воздуха",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var airValueNumberLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 30)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        view.attributedText = NSMutableAttributedString(
            string: "42",
            attributes: [NSAttributedString.Key.kern: 0.6, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var airValueView: UIView = {
        let view = UILabel()
        view.layer.backgroundColor = UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var airValueWordLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: "хорошо",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var airDiscriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        view.attributedText = NSMutableAttributedString(
            string: "Качество воздуха считается удовлетворительным и загрязнения \nвоздуха представляются незначительными \nв пределах нормы",
            attributes: [NSAttributedString.Key.kern: 0.14, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var separatorHoriz00View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorHoriz01View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorHoriz10View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorHoriz11View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorVertView: UIView = {
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
        
        createDottedLine(width: 1.0, view: self.separatorHoriz00View)   // ⭕️ почему-то не работает
        
        self.addSubview(mainView)
        
        self.mainView.addSubview(sunMoonLabel)
        self.mainView.addSubview(fullMoonLabel)
        self.mainView.addSubview(fullMoonImageView)
        
        self.mainView.addSubview(separatorVertView)
        
        self.mainView.addSubview(sunDuration)
        self.mainView.addSubview(sunImageView)
        self.mainView.addSubview(moonDuration)
        self.mainView.addSubview(moonImageView)
        
        self.mainView.addSubview(separatorHoriz00View)
        self.mainView.addSubview(separatorHoriz01View)

        self.mainView.addSubview(sunriseLabel)
        self.mainView.addSubview(sunriseTimeLabel)
        self.mainView.addSubview(moonriseLabel)
        self.mainView.addSubview(moonriseTimeLabel)

        self.mainView.addSubview(separatorHoriz10View)
        self.mainView.addSubview(separatorHoriz11View)

        self.mainView.addSubview(sunsetLabel)
        self.mainView.addSubview(sunsetTimeLabel)
        self.mainView.addSubview(moonsetLabel)
        self.mainView.addSubview(moonsetTimeLabel)

        self.mainView.addSubview(airTitleLabel)
        self.mainView.addSubview(airValueNumberLabel)
        self.mainView.addSubview(airValueView)
        self.airValueView.addSubview(airValueWordLabel)
        self.mainView.addSubview(airDiscriptionLabel)
        
        NSLayoutConstraint.activate([
            
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.sunMoonLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.sunMoonLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.sunMoonLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.fullMoonLabel.centerYAnchor.constraint(equalTo: self.sunMoonLabel.centerYAnchor),
            self.fullMoonLabel.rightAnchor.constraint(equalTo: self.mainView.rightAnchor),
            self.fullMoonLabel.heightAnchor.constraint(equalToConstant: 19),
            
            self.fullMoonImageView.centerYAnchor.constraint(equalTo: self.sunMoonLabel.centerYAnchor),
            self.fullMoonImageView.trailingAnchor.constraint(equalTo: self.fullMoonLabel.leadingAnchor, constant: -5),
            self.fullMoonImageView.heightAnchor.constraint(equalToConstant: 15),
            self.fullMoonImageView.widthAnchor.constraint(equalToConstant: 15),
            
            
            self.separatorVertView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            self.separatorVertView.topAnchor.constraint(equalTo: self.sunMoonLabel.bottomAnchor, constant: 15),
            self.separatorVertView.heightAnchor.constraint(equalToConstant: 100),
            self.separatorVertView.widthAnchor.constraint(equalToConstant: 1),

            self.sunDuration.trailingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor, constant: -17),
            self.sunDuration.topAnchor.constraint(equalTo: self.sunMoonLabel.bottomAnchor, constant: 18),
            self.sunDuration.heightAnchor.constraint(equalToConstant: 20),

            self.sunImageView.centerYAnchor.constraint(equalTo: self.sunDuration.centerYAnchor),
            self.sunImageView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 18),
            self.sunImageView.heightAnchor.constraint(equalToConstant: 20),
            self.sunImageView.widthAnchor.constraint(equalToConstant: 20),

            self.moonDuration.centerYAnchor.constraint(equalTo: self.sunDuration.centerYAnchor),
            self.moonDuration.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.moonDuration.heightAnchor.constraint(equalToConstant: 20),

            self.moonImageView.centerYAnchor.constraint(equalTo: self.moonDuration.centerYAnchor),
            self.moonImageView.leadingAnchor.constraint(equalTo: self.separatorVertView.trailingAnchor, constant: 27),
            self.moonImageView.heightAnchor.constraint(equalToConstant: 20),
            self.moonImageView.widthAnchor.constraint(equalToConstant: 20),

            self.separatorHoriz00View.topAnchor.constraint(equalTo: self.sunDuration.bottomAnchor, constant: 12),
            self.separatorHoriz00View.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.separatorHoriz00View.trailingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor,constant: -12),
            self.separatorHoriz00View.heightAnchor.constraint(equalToConstant: 1),

            self.separatorHoriz01View.centerYAnchor.constraint(equalTo: self.separatorHoriz00View.centerYAnchor),
            self.separatorHoriz01View.leadingAnchor.constraint(equalTo: self.separatorVertView.trailingAnchor, constant: 12),
            self.separatorHoriz01View.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.separatorHoriz01View.heightAnchor.constraint(equalToConstant: 1),
            
            
            self.sunriseLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 17),
            self.sunriseLabel.topAnchor.constraint(equalTo: self.separatorHoriz00View.bottomAnchor, constant: 8),
            self.sunriseLabel.heightAnchor.constraint(equalToConstant: 19),

            self.sunriseTimeLabel.centerYAnchor.constraint(equalTo: self.sunriseLabel.centerYAnchor),
            self.sunriseTimeLabel.trailingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor, constant: -17),
            self.sunriseTimeLabel.heightAnchor.constraint(equalToConstant: 20),

            self.moonriseLabel.centerYAnchor.constraint(equalTo: self.sunriseLabel.centerYAnchor),
            self.moonriseLabel.leadingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor, constant: 27),
            self.moonriseLabel.heightAnchor.constraint(equalToConstant: 19),

            self.moonriseTimeLabel.centerYAnchor.constraint(equalTo: self.sunriseLabel.centerYAnchor),
            self.moonriseTimeLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.moonriseTimeLabel.heightAnchor.constraint(equalToConstant: 20),

            self.separatorHoriz10View.topAnchor.constraint(equalTo: self.sunriseLabel.bottomAnchor, constant: 9),
            self.separatorHoriz10View.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.separatorHoriz10View.trailingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor,constant: -12),
            self.separatorHoriz10View.heightAnchor.constraint(equalToConstant: 1),

            self.separatorHoriz11View.centerYAnchor.constraint(equalTo: self.separatorHoriz10View.centerYAnchor),
            self.separatorHoriz11View.leadingAnchor.constraint(equalTo: self.separatorVertView.trailingAnchor, constant: 12),
            self.separatorHoriz11View.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.separatorHoriz11View.heightAnchor.constraint(equalToConstant: 1),
            
            
            self.sunsetLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 17),
            self.sunsetLabel.topAnchor.constraint(equalTo: self.separatorHoriz10View.bottomAnchor, constant: 8),
            self.sunsetLabel.heightAnchor.constraint(equalToConstant: 19),

            self.sunsetTimeLabel.centerYAnchor.constraint(equalTo: self.sunsetLabel.centerYAnchor),
            self.sunsetTimeLabel.trailingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor, constant: -17),
            self.sunsetTimeLabel.heightAnchor.constraint(equalToConstant: 20),

            self.moonsetLabel.centerYAnchor.constraint(equalTo: self.sunsetLabel.centerYAnchor),
            self.moonsetLabel.leadingAnchor.constraint(equalTo: self.separatorVertView.leadingAnchor, constant: 27),
            self.moonsetLabel.heightAnchor.constraint(equalToConstant: 19),

            self.moonsetTimeLabel.centerYAnchor.constraint(equalTo: self.sunsetLabel.centerYAnchor),
            self.moonsetTimeLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
            self.moonsetTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            self.airTitleLabel.topAnchor.constraint(equalTo: self.sunsetLabel.bottomAnchor, constant: 26),
            self.airTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.airTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.airValueNumberLabel.topAnchor.constraint(equalTo: airTitleLabel.bottomAnchor, constant: 10),
            self.airValueNumberLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 1),
            self.airValueNumberLabel.heightAnchor.constraint(equalToConstant: 36),
            
            self.airValueView.centerYAnchor.constraint(equalTo: self.airValueNumberLabel.centerYAnchor),
            self.airValueView.leadingAnchor.constraint(equalTo: self.airValueNumberLabel.trailingAnchor, constant: 15),
            self.airValueView.heightAnchor.constraint(equalToConstant: 26),
            self.airValueView.widthAnchor.constraint(equalToConstant: 95),
            
            self.airValueWordLabel.centerYAnchor.constraint(equalTo: self.airValueView.centerYAnchor),
            self.airValueWordLabel.centerXAnchor.constraint(equalTo: self.airValueView.centerXAnchor),

            self.airDiscriptionLabel.topAnchor.constraint(equalTo: self.airValueNumberLabel.bottomAnchor, constant: 10),
            self.airDiscriptionLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.airDiscriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -23)
        ])
    }

    func setupValues(with viewModel: SunMoonAirViewModel) {
        sunDuration.text = viewModel.sunDuration
        sunriseTimeLabel.text = viewModel.sunRise
        sunsetTimeLabel.text = viewModel.sunSet
        moonDuration.text = viewModel.moonDuration
        moonriseTimeLabel.text = viewModel.moonRise
        moonsetTimeLabel.text = viewModel.moonSet
        airValueNumberLabel.text = viewModel.airQuality
    }
}



extension UIView {
    func createDottedLine(width: CGFloat, view: UIView) {
        let caShapeLayer = CAShapeLayer()
//        caShapeLayer.strokeColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        caShapeLayer.strokeColor = UIColor.white.cgColor

        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [3,3]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: view.bounds.minX, y: view.bounds.minY), CGPoint(x: view.bounds.maxX, y: view.bounds.minY)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        view.layer.addSublayer(caShapeLayer)
    }
}
