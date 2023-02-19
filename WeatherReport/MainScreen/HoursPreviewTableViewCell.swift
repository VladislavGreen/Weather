//
//  HoursPreviewTableViewCell.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/4/23.
//

import UIKit
import CoreData


class HoursPreviewTableViewCell: UITableViewCell  {

    
    var hours: [Hour]?
    
    var selectedIndex: IndexPath?
    
    var cellAction: (()->())?
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 6
    }
    
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        return layout
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HoursPreviewCollectionViewCell.self, forCellWithReuseIdentifier: "HoursPreviewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    private func setupView() {
        
        self.contentView.addSubview(self.collectionView)
                
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 84)
        ])
    }
    
    func setupHours(hours: [Hour]) {
        self.hours = hours
    }
    
}



extension HoursPreviewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = hours?.count else { return 0 }
        return number
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursPreviewCell", for: indexPath) as? HoursPreviewCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let backColor: CGColor
        let textColor: UIColor
        
        if indexPath == selectedIndex {
            backColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
            textColor = .white
        } else {
            backColor = UIColor.white.cgColor
            textColor = .black
        }
        
        let hour = hours?[indexPath.row].hour ?? "25:25"
        
        let tempInt = hours?[indexPath.row].temp
        let temp = "\(tempInt ?? -273)°"
        
        let precType = hours?[indexPath.row].precType
        let precImage = DataConverters.shared.getPrecPicture(byNumber: precType)
        
        let viewModel = HoursPreviewCollectionViewCell.HoursPreviewViewModel(
            hourText: hour,
            conditionImage: precImage,
            tempText: temp,
            backColor: backColor,
            textColor: textColor
        )
        cell.setupValues(with: viewModel)
        cell.tapHandler = {
            print("collectionView tapHandler \(indexPath.row)")
            self.cellAction!()
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 42, height: 84)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        print("collectionView didSelectItemAt \(indexPath.row)")
        collectionView.reloadData()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursPreviewCell", for: indexPath) as? HoursPreviewCollectionViewCell {
            cell.tapHandler!()
        }
    }

}
