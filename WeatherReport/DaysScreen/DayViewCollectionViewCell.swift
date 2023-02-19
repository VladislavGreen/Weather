//
//  DayViewCollectionViewCell.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/19/23.
//

import UIKit

class DayViewCollectionViewCell: UICollectionViewCell {
    
    struct DayCollectionCellViewModel {
        let labelText: String
        let labelTextColor: UIColor
        let viewColor: CGColor
    }
    
    var tapHandler: (()->())?
    
    private lazy var view: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(cellTapped), for: .touchUpInside)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Light_Regular", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "16/04 ПТ",
            attributes: [NSAttributedString.Key.kern: -0.18, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
    
    func setupValues(with viewModel: DayCollectionCellViewModel) {
        self.viewLabel.text = viewModel.labelText
        self.viewLabel.textColor = viewModel.labelTextColor
        self.view.layer.backgroundColor = viewModel.viewColor
    }
    
    private func setupView() {
        self.addSubview(self.view)
        self.view.addSubview(viewLabel)
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.topAnchor),
            self.view.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.view.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.view.heightAnchor.constraint(equalToConstant: 36),
            
            self.viewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
            self.viewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            self.viewLabel.heightAnchor.constraint(equalToConstant: 22),
            self.viewLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -7)
        ])
    }
    
    @objc
    func cellTapped() {
        tapHandler?()
    }
}
