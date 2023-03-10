//
//  DayViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 2/9/23.
//

import UIKit
import CoreData


class DayViewController: UIViewController {
    
    var forecast: Forecast?
    var forecasts: [Forecast]?
    
    var selectedIndex: IndexPath?
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Medium", size: 18)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.03
        view.attributedText = NSMutableAttributedString(
            string: "City, Country",
            attributes: [NSAttributedString.Key.kern: 0.36, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
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
        collectionView.register(DayViewCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(mainScrollView)
        
        titleLabel.text = forecast?.ofWeather?.cityName
        mainScrollView.addSubview(titleLabel)
        
        mainScrollView.addSubview(collectionView)
        
                
        let day: DayShort = CoreDataManager.defaultManager.getDayData(forecast: forecast)!
        
        let dayView = DaypartView()
        let viewModelDay = DaypartView.DaypartViewModel(
            daypart: "????????",
            temp: "\(day.tempAverage)??",
            precStrength: day.precStrength,
            condition: day.condition ?? "no data"
        )
        dayView.setupValues(with: viewModelDay)
        dayView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(dayView)

        let dayFeelsRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "termometerSun")!,
            titleLabelText: "???? ??????????????????",
            valueText: "\(day.feelsLike)??"
        )
        let dayFeelsRowView = DaypartRowView()
        dayFeelsRowView.setupValues(with: dayFeelsRow)
        dayFeelsRowView.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayFeelsRowView)
        
        let windDir = DataConverters.shared.getWindDirection(byString: day.windDirection ?? "?????? ????????????")
        let dayWindRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "windRow")!,
            titleLabelText: "??????????",
            valueText: "\(day.windSpeed) ??/?? \(windDir)"
        )
        let dayWindRowView = DaypartRowView()
        dayWindRowView.setupValues(with: dayWindRow)
        dayWindRowView.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayWindRowView)
        
        // ???? ?? API ??????????????????????, ?????????????? ??????:
        let dayUFRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionClear")!,
            titleLabelText: "???? ????????????",
            valueText: "4 [????????????]"
        )
        let dayUFRowView = DaypartRowView()
        dayUFRowView.setupValues(with: dayUFRow)
        dayUFRowView.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayUFRowView)
        
        let dayRainRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionRain")!,
            titleLabelText: "????????????",
            valueText: "\(day.precMM) ????"
        )
        let dayRainRowView = DaypartRowView()
        dayRainRowView.setupValues(with: dayRainRow)
        dayRainRowView.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayRainRowView)
        
        let dayCloudsRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionClouds")!,
            titleLabelText: "????????????????????",
            valueText: "\(day.cloudness)%"
        )
        let dayCloudsRowView = DaypartRowView()
        dayCloudsRowView.setupValues(with: dayCloudsRow)
        dayCloudsRowView.translatesAutoresizingMaskIntoConstraints = false
        dayView.addSubview(dayCloudsRowView)
        
        
        let night: Night = CoreDataManager.defaultManager.getNightData(forecast: forecast)!
        let nightView = DaypartView()
        let viewModelNight = DaypartView.DaypartViewModel(
            daypart: "????????",
            temp: "\(night.tempAverage)??",
            precStrength: night.precStrength,
            condition: night.condition ?? "no data"
        )
        nightView.setupValues(with: viewModelNight)
        nightView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(nightView)
        
        
        let nightFeelsRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "termometerSun")!,
            titleLabelText: "???? ??????????????????",
            valueText: "\(night.feelsLike)??"
        )
        let nightFeelsRowView = DaypartRowView()
        nightFeelsRowView.setupValues(with: nightFeelsRow)
        nightFeelsRowView.translatesAutoresizingMaskIntoConstraints = false
        nightView.addSubview(nightFeelsRowView)
        
        let nightWindDir = DataConverters.shared.getWindDirection(byString: day.windDirection ?? "?????? ????????????")
        let nightWindRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "windRow")!,
            titleLabelText: "??????????",
            valueText: "\(night.windSpeed) ??/?? \(nightWindDir)"
        )
        let nightWindRowView = DaypartRowView()
        nightWindRowView.setupValues(with: nightWindRow)
        nightWindRowView.translatesAutoresizingMaskIntoConstraints = false
        nightView.addSubview(nightWindRowView)
        
        // ???? ?? API ??????????????????????, ?????????????? ??????:
        let nightUFRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionClear")!,
            titleLabelText: "???? ????????????",
            valueText: "4 [????????????]"
        )
        let nightUFRowView = DaypartRowView()
        nightUFRowView.setupValues(with: nightUFRow)
        nightUFRowView.translatesAutoresizingMaskIntoConstraints = false
        nightView.addSubview(nightUFRowView)
        
        let nightRainRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionRain")!,
            titleLabelText: "????????????",
            valueText: "\(night.precMM) ????"
        )
        let nightRainRowView = DaypartRowView()
        nightRainRowView.setupValues(with: nightRainRow)
        nightRainRowView.translatesAutoresizingMaskIntoConstraints = false
        nightView.addSubview(nightRainRowView)
        
        let nightCloudsRow = DaypartRowView.DaypartRowViewModel(
            picImage: UIImage(named: "conditionClouds")!,
            titleLabelText: "????????????????????",
            valueText: "\(night.cloudness)%"
        )
        let nightCloudsRowView = DaypartRowView()
        nightCloudsRowView.setupValues(with: nightCloudsRow)
        nightCloudsRowView.translatesAutoresizingMaskIntoConstraints = false
        nightView.addSubview(nightCloudsRowView)
        
        
        guard let sunrise = forecast?.sunrise, let sunset = forecast?.sunset else {
            _ = "????????????????"
            return
        }
        let sunDuration = getTimeDifference(timeSet: sunset, timeRise: sunrise)
        
        let sunMoonAirValues = SunMoonAirView.SunMoonAirViewModel(
            sunDuration: sunDuration,
            sunRise: sunrise,
            sunSet: sunset,
            moonDuration: sunDuration,  // ?????? ?? API ????????????-????????????
            moonRise: sunrise,          // ?????? ?? API ????????????-????????????
            moonSet: sunset,            // ?????? ?? API ????????????-????????????
            airQuality: "42"            // ?????? ?? API ????????????-????????????
        )
        let sunMoonAirView = SunMoonAirView()
        sunMoonAirView.setupValues(with: sunMoonAirValues)
        sunMoonAirView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(sunMoonAirView)
        
        NSLayoutConstraint.activate([
            
            self.mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            self.mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            self.collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
            self.collectionView.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.mainScrollView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 36),
           
            dayView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 40),
            dayView.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor),
            dayView.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            dayView.heightAnchor.constraint(equalToConstant: 341),
            
            dayFeelsRowView.topAnchor.constraint(equalTo: dayView.topAnchor, constant: 99),
            dayFeelsRowView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayFeelsRowView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            
            dayWindRowView.topAnchor.constraint(equalTo: dayFeelsRowView.bottomAnchor, constant: 0),
            dayWindRowView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayWindRowView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            
            dayUFRowView.topAnchor.constraint(equalTo: dayWindRowView.bottomAnchor, constant: 0),
            dayUFRowView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayUFRowView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            
            dayRainRowView.topAnchor.constraint(equalTo: dayUFRowView.bottomAnchor, constant: 0),
            dayRainRowView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayRainRowView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            
            dayCloudsRowView.topAnchor.constraint(equalTo: dayRainRowView.bottomAnchor, constant: 0),
            dayCloudsRowView.leadingAnchor.constraint(equalTo: dayView.leadingAnchor),
            dayCloudsRowView.trailingAnchor.constraint(equalTo: dayView.trailingAnchor),
            
            nightView.topAnchor.constraint(equalTo: dayView.bottomAnchor, constant: 12),
            nightView.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor),
            nightView.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            nightView.heightAnchor.constraint(equalToConstant: 341),
            
            nightFeelsRowView.topAnchor.constraint(equalTo: nightView.topAnchor, constant: 99),
            nightFeelsRowView.leadingAnchor.constraint(equalTo: nightView.leadingAnchor),
            nightFeelsRowView.trailingAnchor.constraint(equalTo: nightView.trailingAnchor),
            
            nightWindRowView.topAnchor.constraint(equalTo: nightFeelsRowView.bottomAnchor, constant: 0),
            nightWindRowView.leadingAnchor.constraint(equalTo: nightView.leadingAnchor),
            nightWindRowView.trailingAnchor.constraint(equalTo: nightView.trailingAnchor),
            
            nightUFRowView.topAnchor.constraint(equalTo: nightWindRowView.bottomAnchor, constant: 0),
            nightUFRowView.leadingAnchor.constraint(equalTo: nightView.leadingAnchor),
            nightUFRowView.trailingAnchor.constraint(equalTo: nightView.trailingAnchor),
            
            nightRainRowView.topAnchor.constraint(equalTo: nightUFRowView.bottomAnchor, constant: 0),
            nightRainRowView.leadingAnchor.constraint(equalTo: nightView.leadingAnchor),
            nightRainRowView.trailingAnchor.constraint(equalTo: nightView.trailingAnchor),
            
            nightCloudsRowView.topAnchor.constraint(equalTo: nightRainRowView.bottomAnchor, constant: 0),
            nightCloudsRowView.leadingAnchor.constraint(equalTo: nightView.leadingAnchor),
            nightCloudsRowView.trailingAnchor.constraint(equalTo: nightView.trailingAnchor),
            
            sunMoonAirView.topAnchor.constraint(equalTo: nightView.bottomAnchor, constant: 20),
            sunMoonAirView.leadingAnchor.constraint(equalTo: self.mainScrollView.leadingAnchor),
            sunMoonAirView.trailingAnchor.constraint(equalTo: self.mainScrollView.trailingAnchor),
            sunMoonAirView.widthAnchor.constraint(equalTo: self.mainScrollView.widthAnchor),
            
            sunMoonAirView.bottomAnchor.constraint(equalTo: self.mainScrollView.bottomAnchor),
        ])
    }
    
    
    private func getTimeDifference(timeSet: String, timeRise: String) -> String {
        print("\(timeSet)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let timeSetDate = dateFormatter.date(from: timeSet) else {
            print("Fail")
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        guard let timeRiseDate = dateFormatter.date(from: timeRise) else {
            print("Another fail")
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        let difference = Calendar.current.dateComponents([.hour, .minute], from: timeRiseDate, to: timeSetDate)
        let result = "\(difference.hour!)??.\(difference.minute!)??."
        
        return result
    }
}



extension DayViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = forecasts?.count else { return 0 }
        return number
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? DayViewCollectionViewCell else {
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
        
        let forecast = forecasts?[indexPath.row]
        
        let dateTS = forecast?.dateTS
        let dateText = DataConverters.shared.formatDate3(unixDateToConvert: dateTS!)
        
        let viewModel = DayViewCollectionViewCell.DayCollectionCellViewModel(
            labelText: dateText,
            labelTextColor: textColor,
            viewColor: backColor
        )
        cell.setupValues(with: viewModel)
        
        cell.tapHandler = { [weak self] in
//            print("collectionView cellForItemAt tapHandler \(indexPath.row)")
            self?.forecast = forecast
            self?.setupView()
            self?.selectedIndex = indexPath
            collectionView.reloadData()
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 88, height: 36)
    }
    
}


