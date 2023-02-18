//
//  MainViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/5/23.
//

import UIKit
import CoreData


class MainViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // Переменная для получения данных
    var weather: Weather?
    
    // Переменная для передачи данных в HoursViewController и в HoursPreviewTableViewCell
    var forecastToday: Forecast?
    
    // Переменная для передачи данных в DayViewController
    var forecasts: [Forecast] = []
    
    var fetchedResultsController: NSFetchedResultsController<Forecast>?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = view.backgroundColor
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 15)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 10
        tableView.estimatedRowHeight = 56
        tableView.layer.cornerRadius = 5
        tableView.register(MainHeaderView.self, forHeaderFooterViewReuseIdentifier: "MainHeaderView")
        tableView.register(DaysHeaderView.self, forHeaderFooterViewReuseIdentifier: "DaysHeaderView")
        tableView.register(HoursPreviewTableViewCell.self, forCellReuseIdentifier: "HoursPreviewCell")
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: "DaysCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var plusButton: UIButton = {
        let image = UIImage(systemName: "plus")
        image?.withTintColor(.darkGray)
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFetchedResultsController()
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        
        setupView()
        
        DispatchQueue.global(qos: .default).async {
            self.updateCoreDataValues(for: self.weather)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = weather?.cityName
    }
    

    
    
    private func initFetchedResultsController() {
        let fetchRequest = Forecast.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        if let weather {
            fetchRequest.predicate = NSPredicate(format: "ofWeather == %@", weather) }
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext,
            sectionNameKeyPath: "date",
            cacheName: nil)
        
        fetchedResultsController = frc
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
//        self.navigationController?.navigationItem.title = weather?.cityName
//        self.navigationItem.title = weather?.cityName
//        self.navigationController?.title = weather?.cityName
//        self.title = weather?.cityName
//        self.navigationController?.navigationBar.topItem?.title = weather?.cityName
//        self.navigationController?.presentationController?.presentingViewController.title = weather?.cityName
//        self.navigationController?.parent?.navigationItem.title = weather?.cityName

        
        self.view.addSubview(tableView)
        
        if weather == nil {
            self.view.addSubview(plusButton)
            NSLayoutConstraint.activate([
                self.plusButton.widthAnchor.constraint(equalToConstant: 100),
                self.plusButton.heightAnchor.constraint(equalToConstant: 100),
                self.plusButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.plusButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        }
    
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func updateCoreDataValues(for weather: Weather?) {
        
        guard weather != nil else {
            Alerts.defaultAlert.showOkAlert(title: "Не можем обновить данные", message: "Проверьте соединение")
            return
        }
            
        guard
            let lat = weather?.info?.lat,
            let lon = weather?.info?.lon,
            let locationName = weather?.cityName
        else {
            print("MainViewController updateCoreDataValues что-то не так")
            return
        }
        
        downloadWeatherInfo(lat: lat, lon: lon) { weather, errorString in
            
            CoreDataManager.defaultManager.setCoreDataCash(weather: weather!, locationName: locationName ) {
                DispatchQueue.main.async {
                    self.forecasts = []
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    @objc
    private func plusButtonPressed() {
        print("emptyButtonPressed")
    }
}



extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MainHeaderView") as? MainHeaderView
                
            let indexPath = IndexPath(item: 0, section: 0)
            let forecastFetched = fetchedResultsController?.object(at: indexPath)
            let tap = UITapGestureRecognizer(target: self, action: #selector(pushHoursViewController))
            
            guard let weatherForObject = forecastFetched?.ofWeather else {
                view?.setupValues(weatherForCity: weather!, more24LabelAction: tap)
                return view
            }
 
            view?.setupValues(weatherForCity: weatherForObject, more24LabelAction: tap)
            return view
        }
        
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DaysHeaderView") as? DaysHeaderView
            return view
        }
        
        else {
            return nil
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController?.sections as [NSFetchedResultsSectionInfo]? else {
            return 0
        }
        return sections.count + 1   // Учитываем одну секцию для CollectionView с превью почасовой погоды
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HoursPreviewCell", for: indexPath) as! HoursPreviewTableViewCell
            
            // для кнопки more24Hours - там свой FRC
            if let object = fetchedResultsController?.object(at: [indexPath.section, indexPath.row]) {
                forecastToday = object
            }
            
            // попробуем запулить второй FRC
            
            let fetchRequest = Hour.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "hour", ascending: true)]
            if let forecastToday {
                fetchRequest.predicate = NSPredicate(format: "ofForecast == %@", forecastToday) }
            let fetchedResultsControllerHours = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            fetchedResultsControllerHours.delegate = self
            try? fetchedResultsControllerHours.performFetch()
            
            var hoursEveryThird: [Hour] = []
            for index in 0...23 {
                let objectHours = fetchedResultsControllerHours.object(at: [indexPath.section, index])
                if index % 3 == 0 {
                    hoursEveryThird.append(objectHours)
                }
            }
            cell.setupHours(hours: hoursEveryThird)
            return cell
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysTableViewCell
            
            let object = fetchedResultsController?.object(at: [indexPath.section - 1, indexPath.row])
            
            // добавляем в массив для отправки в DayViewController
            forecasts.append(object!)
            
            
            
            print("cellForRowAt \(forecasts.count)")
            
            // форматируем дату
            let dateFetched = object?.dateTS ?? 0
            let dateConverted = DataConverters.shared.formatDate2(unixDateToConvert: dateFetched)
            
            // определяем и картинку для типа осадков
            let precTypeNumberFetched = object?.dayShort?.precType
            let precImage = DataConverters.shared.getPrecPicture(byNumber: precTypeNumberFetched)
            
            // Влажность
            let humidity = object?.dayShort?.humidity
            let humidityText = "\(humidity ?? 0)%"
            
            // Температура Min/Max
            let minTemp = object?.dayShort?.tempMin
            let maxTemp = object?.dayShort?.tempMax
            let minMaxTemp = "\(minTemp!)°/\(maxTemp!)°"
            
            // Описание погодных условий
            let condition = object?.dayShort?.condition ?? "No data"
            let conditionDescription = DataConverters.shared.getConditionDescription(byString: condition)
            
            let viewModel = DaysTableViewCell.ViewModel(
                dateText: dateConverted,
                humidityText: humidityText,
                precImage: precImage,
                condition: conditionDescription,
                minMaxTemp: minMaxTemp
            )
            
            cell.setupValues(with: viewModel)
            
            cell.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 84
        } else {
            return 56
        }
    }
    

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
          return 401
        }
        if section == 1 {
            return 56
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        print("tableView didSelectRowAt")
        if let object = fetchedResultsController?.object(at: [indexPath.section - 1, indexPath.row]) {
            let vc = DayViewController()
            vc.forecast = object
            vc.forecasts = forecasts
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc
    func pushHoursViewController() {
        print("more24LabelTapped")
        let vc = HoursViewController()
        vc.forecast = forecastToday
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


