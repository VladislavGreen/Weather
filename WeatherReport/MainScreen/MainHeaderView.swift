//
//  TodayTableHeaderView.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/25/23.
//

import UIKit


class MainHeaderView: UITableViewHeaderFooterView {
    
    
    private lazy var mainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var arcImageView : UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Ellipse_3")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var sunriseImageView : UIImageView = {
        let color = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        let image = UIImage(named: "sunrise")?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
            imageView.image = image
            imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var sunsetImageView : UIImageView = {
        let color = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        let image = UIImage(named: "sunset")?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
            imageView.image = image
            imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Фактическая температура
    private lazy var factTempLabel: UILabel = {
        var view = UILabel()
            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.font = UIFont(name: "Rubik-Light_Medium", size: 36)
            view.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.94
        view.attributedText = NSMutableAttributedString(
                string: "",
                attributes: [NSAttributedString.Key.kern: 3.06,
                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Погодные условия
    private lazy var conditionLabel: UILabel = {
        var view = UILabel()
            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
            view.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Облачность, ветер, дождь
    private lazy var activitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var cloudnessImageView: UIImageView = {
        let image = UIImage(named: "cloudness")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.kern: 0.14,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windImageView: UIImageView = {
        let image = UIImage(named: "wind")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: " м/с",
            attributes: [NSAttributedString.Key.kern: 0.14,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rainImageView: UIImageView = {
        let image = UIImage(named: "rain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: "%",
            attributes: [NSAttributedString.Key.kern: 0.14,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Время и дата прогноза
    private lazy var dateLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.kern: 0.16,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Пропускаем пока часть переменных (min/max, sunrise, sunset), т.к. их фактическое значение наш API не предосталяет
    
    @objc private lazy var more24Label: UILabel = {
        var view = UILabel()
            view.frame = CGRect(x: 0, y: 0, width: 174, height: 20)
            view.backgroundColor = .white
            view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
            view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
        view.textAlignment = .right
        view.isUserInteractionEnabled = true
        view.attributedText = NSMutableAttributedString(
            string: "Подробнее на 24 часа",
            attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                         NSAttributedString.Key.kern: 0.16,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        view .translatesAutoresizingMaskIntoConstraints = false
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
        contentView.backgroundColor = .white
        contentView.addSubview(mainView)
        mainView.addSubview(arcImageView)
        mainView.addSubview(sunriseImageView)
        mainView.addSubview(sunsetImageView)
        mainView.addSubview(factTempLabel)
        mainView.addSubview(conditionLabel)
        mainView.addSubview(activitiesLabel)
        activitiesLabel.addSubview(cloudnessImageView)
        activitiesLabel.addSubview(cloudnessLabel)
        activitiesLabel.addSubview(windImageView)
        activitiesLabel.addSubview(windLabel)
        activitiesLabel.addSubview(rainImageView)
        activitiesLabel.addSubview(rainLabel)
        mainView.addSubview(dateLabel)
        contentView.addSubview(more24Label)
        
        NSLayoutConstraint.activate([
            
            mainView.heightAnchor.constraint(equalToConstant: 212),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 112),
            
            arcImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 33),
            arcImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -31),
            arcImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 17),
            
            sunriseImageView.widthAnchor.constraint(equalToConstant: 17),
            sunriseImageView.heightAnchor.constraint(equalToConstant: 17),
            sunriseImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 145),
            sunriseImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 25),
            
            sunsetImageView.widthAnchor.constraint(equalToConstant: 17),
            sunsetImageView.heightAnchor.constraint(equalToConstant: 17),
            sunsetImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 145),
            sunsetImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            
            factTempLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 58),
            factTempLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            factTempLabel.widthAnchor.constraint(equalToConstant: 60),
            factTempLabel.heightAnchor.constraint(equalToConstant: 40),
            
            conditionLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 103),
            conditionLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 5),
            conditionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            activitiesLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 131),
            activitiesLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            activitiesLabel.widthAnchor.constraint(equalToConstant: 189),
            activitiesLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cloudnessImageView.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            cloudnessImageView.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            cloudnessImageView.leadingAnchor.constraint(equalTo: activitiesLabel.leadingAnchor),
            cloudnessImageView.widthAnchor.constraint(equalToConstant: 20),
            cloudnessImageView.heightAnchor.constraint(equalToConstant: 18),
            
            cloudnessLabel.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            cloudnessLabel.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            cloudnessLabel.leadingAnchor.constraint(equalTo: cloudnessImageView.trailingAnchor, constant: 5.04),
            
            windImageView.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            windImageView.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            windImageView.leadingAnchor.constraint(equalTo: cloudnessLabel.trailingAnchor, constant: 21.03),
            windImageView.widthAnchor.constraint(equalToConstant: 20),
            windImageView.heightAnchor.constraint(equalToConstant: 18),
            
            windLabel.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            windLabel.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 5.27),
            
            rainImageView.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            rainImageView.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            rainImageView.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 19.31),
            rainImageView.widthAnchor.constraint(equalToConstant: 20),
            rainImageView.heightAnchor.constraint(equalToConstant: 18),
            
            rainLabel.topAnchor.constraint(equalTo: activitiesLabel.topAnchor, constant: 7),
            rainLabel.bottomAnchor.constraint(equalTo: activitiesLabel.bottomAnchor, constant: -5),
            rainLabel.leadingAnchor.constraint(equalTo: rainImageView.trailingAnchor, constant: 5.46),
            
            dateLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 171),
            dateLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            more24Label.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 33),
            more24Label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            more24Label.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func setupValues(weatherForCity: Weather?, more24LabelAction: UITapGestureRecognizer) {

        factTempLabel.text = "\(weatherForCity?.factTemp ?? -273)°"
        let condition = weatherForCity?.factCondition
        if let condition {
            conditionLabel.text = DataConverters.shared.getConditionDescription(byString: condition)
        }
        cloudnessLabel.text = "\(weatherForCity?.factCloudness ?? 0)"
        windLabel.text = "\(weatherForCity?.factWindSpeed ?? 0)"
        rainLabel.text = "\(weatherForCity?.factPrecProb ?? 0)"
        dateLabel.text = DataConverters.shared.formatDate1(unixDateToConvert: weatherForCity?.now ?? 0)
        
        more24Label.addGestureRecognizer(more24LabelAction)
    }
}
