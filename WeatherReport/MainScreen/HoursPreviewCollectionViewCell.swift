//
//  HoursPreviewCollectionViewCell.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/4/23.
//

import UIKit


class HoursPreviewCollectionViewCell: UICollectionViewCell {
    
    struct HoursPreviewViewModel {
        let hourText: String
        let conditionImage: UIImage
        let tempText: String
    }
    
    private lazy var previewView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hourLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 37, height: 18)
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 13)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "12:00",
            attributes: [NSAttributedString.Key.kern: 0.28, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var conditionImageView: UIImageView = {
        let image = UIImage(named: "conditionRain")
        let view = UIImageView()
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 18)
        view.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.95
        view.textAlignment = .right
        view.attributedText = NSMutableAttributedString(
            string: "23°",
            attributes: [NSAttributedString.Key.kern: 0.32, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupValues(with viewModel: HoursPreviewViewModel) {
        self.hourLabel.text = viewModel.hourText
        self.conditionImageView.image = viewModel.conditionImage
        self.tempLabel.text = viewModel.tempText
    }
    
    private func setupView() {
        self.addSubview(self.previewView)
        self.previewView.addSubview(hourLabel)
        self.previewView.addSubview(conditionImageView)
        self.previewView.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            self.previewView.topAnchor.constraint(equalTo: self.topAnchor),
            self.previewView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.previewView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.previewView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.hourLabel.topAnchor.constraint(equalTo: previewView.topAnchor, constant: 15),
            self.hourLabel.leadingAnchor.constraint(equalTo: previewView.leadingAnchor, constant: 3),
            self.hourLabel.trailingAnchor.constraint(equalTo: previewView.trailingAnchor, constant: -2),
            
            self.conditionImageView.centerXAnchor.constraint(equalTo: previewView.centerXAnchor),
            self.conditionImageView.centerYAnchor.constraint(equalTo: previewView.centerYAnchor, constant: 2),
            self.conditionImageView.heightAnchor.constraint(equalToConstant: 16),
            self.conditionImageView.widthAnchor.constraint(equalToConstant: 16),
            
            self.tempLabel.bottomAnchor.constraint(equalTo: previewView.bottomAnchor, constant: -8),
            self.tempLabel.centerXAnchor.constraint(equalTo: previewView.centerXAnchor, constant: 0),
            
        ])
    }
}
