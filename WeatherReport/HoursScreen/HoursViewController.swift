//
//  24hoursViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/31/23.
//

import UIKit
import CoreData


class HoursViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // Переменная для получения данных
    weak var forecast: Forecast?
    
    var fetchedResultsController: NSFetchedResultsController<Hour>?
    
    func initFetchedResultsController() {
        let fetchRequest = Hour.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "hour", ascending: true)]
        if let forecast {
            fetchRequest.predicate = NSPredicate(format: "ofForecast == %@", forecast) }
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController = frc
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = view.backgroundColor
        tableView.sectionHeaderTopPadding = 20
        tableView.separatorStyle = .none  // если .singleLine, то проблема с constraints
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedSectionHeaderHeight = 209
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 145
        tableView.layer.cornerRadius = 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HoursHeaderView.self, forHeaderFooterViewReuseIdentifier: "HoursHeaderView")
        tableView.register(HourTableViewCell.self, forCellReuseIdentifier: "HourCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFetchedResultsController()
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        
        self.navigationController?.navigationBar.backItem?.title = "Подробнее 24 часа" // Сбрасывает на Back
//        self.navigationController?.navigationBar.topItem?.title = "Подробнее 24 часа" // Меняет название у parentVC

        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}



extension HoursViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HoursHeaderView") as? HoursHeaderView
        
        let object = fetchedResultsController?.object(at: [0, 0])
        
        let cityName = object?.ofForecast?.ofWeather?.cityName ?? "no data"
        
        //  ⭕️ ПЕРЕДАТЬ ДАННЫЕ ДЛЯ ПОСТРОЕНИЯ ГРАФИКА
        
        view?.setupValues(title: cityName)
        return view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell", for: indexPath) as! HourTableViewCell
        
        let object = fetchedResultsController?.object(at: [indexPath.section, indexPath.row])
        
        let dateFetched = object?.ofForecast?.dateTS ?? 0
        let date = DataConverters.shared.formatDate3(unixDateToConvert: dateFetched)
        
        let hourFetched = object?.hour
        //        let hour = DataConverters.shared.getHourNumber(byString: hourFetched!)
        let hour = hourFetched!
        
        let tempFetched = object?.temp
        let temp = "\(String(describing: tempFetched!))" + "°"
        
        let feelsLikeFetched = object?.feelsLike
        let feelsLike = "\(String(describing: feelsLikeFetched!))°"
        
        let windSpeedFetched = object?.windSpeed
        let windDirFetched = object?.windDir
        let windDirConverted = DataConverters.shared.getWindDirection(byString: windDirFetched!)
        let windUnits = " м/с"
        let wind = "\(String(describing: windSpeedFetched!))\(windUnits)   \(windDirConverted)"
        
        let precStrengthFetched = object?.precStrength
        let precStrengthPercents = precStrengthFetched! * 100
        let precStrength = "\(precStrengthPercents)%"
        
        let cloudnessFetched = object?.cloudness
        let cloudnessPercents = cloudnessFetched! * 100
        let cloudness = "\(cloudnessPercents)%"
        
        let viewModel = HourTableViewCell.HourViewModel(
            dateText: date,
            hourText: hour,
            tempText: temp,
            feelsLike: feelsLike,
            wind: wind,
            precStrength: precStrength,
            cloudness: cloudness
        )
        
        cell.setupValues(with: viewModel)
        
        cell.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        cell.clipsToBounds = true
        
        
        // ПЛОХО, нужно понять как работать с данными:
//        if indexPath.row % 3 != 0 {
//            cell.isHidden = true
//        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // ПЛОХО, нужно понять как работать с данными
//        if indexPath.row % 3 != 0 {
//            return 0
//        } else {
            return UITableView.automaticDimension
//        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            //            return 292
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    }
}
