//
//  DaysTableViewCell.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/18/23.
//

import UIKit


class DaysTableViewCell: UITableViewCell {
    
    
    struct ViewModel {
        let dateText: String
        let humidityText: String
        let precImage: UIImage
        let condition: String
        let minMaxTemp: String
    }
    
    
    private lazy var cellDateLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(string: "17/04", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view .translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var humidityLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        view.attributedText = NSMutableAttributedString(string: "57%", attributes: [NSAttributedString.Key.kern: -0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view .translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var precipitationImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var conditionLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: "Местами дождь",
            attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view .translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var minMaxTempLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        view.attributedText = NSMutableAttributedString(
            string: "4° -11°",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view .translatesAutoresizingMaskIntoConstraints = false
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
        self.cellDateLabel.text = nil
        self.humidityLabel.text = nil
        self.precipitationImageView.image = nil
        self.conditionLabel.text = nil
        self.minMaxTempLabel.text = nil
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupValues(with viewModel: ViewModel) {
        self.cellDateLabel.text = viewModel.dateText
        self.humidityLabel.text = viewModel.humidityText
        self.precipitationImageView.image = viewModel.precImage
        self.conditionLabel.text = viewModel.condition
        self.minMaxTempLabel.text = viewModel.minMaxTemp
    }
    
    func setupView() {
        self.contentView.addSubview(self.cellDateLabel)
        self.contentView.addSubview(self.humidityLabel)
        self.contentView.addSubview(self.precipitationImageView)
        self.contentView.addSubview(self.conditionLabel)
        self.contentView.addSubview(self.minMaxTempLabel)
        
        NSLayoutConstraint.activate([
            
            self.contentView.heightAnchor.constraint(equalToConstant: 56),
            
            self.cellDateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            self.cellDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.cellDateLabel.heightAnchor.constraint(equalToConstant: 19),
            
            self.precipitationImageView.topAnchor.constraint(equalTo: cellDateLabel.bottomAnchor, constant: 5.13),
            self.precipitationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            self.precipitationImageView.heightAnchor.constraint(equalToConstant: 17.08),
            self.precipitationImageView.widthAnchor.constraint(equalToConstant: 15),
            
            self.humidityLabel.topAnchor.constraint(equalTo: cellDateLabel.bottomAnchor, constant: 6),
            self.humidityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            self.humidityLabel.heightAnchor.constraint(equalToConstant: 15.19),
            
            self.conditionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19),
            self.conditionLabel.heightAnchor.constraint(equalToConstant: 19),
            self.conditionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -18),
            self.conditionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 66),
            self.conditionLabel.widthAnchor.constraint(equalToConstant: 206),
            
            self.minMaxTempLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 17),
            self.minMaxTempLabel.heightAnchor.constraint(equalToConstant: 19),
            self.minMaxTempLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -26),
        ])
    }
}
