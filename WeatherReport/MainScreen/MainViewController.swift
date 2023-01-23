//
//  MainViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/5/23.
//

import UIKit
import CoreData

class MainViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    
    var weatherForCity: Weather?    // Пока используется без FRC
    
    var forecast: Forecast?
    
    var fetchedResultsController: NSFetchedResultsController<Forecast>?
    
    func initFetchedResultsController() {
        let fetchRequest = Forecast.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: CoreDataManager.defaultManager.persistentContainer.viewContext,
            sectionNameKeyPath: "date",
            cacheName: nil)
        
        fetchedResultsController = frc
    }
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
//        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
    private var factTempText = String()
    private lazy var factTempLabel: UILabel = {
        var view = UILabel()
            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.font = UIFont(name: "Rubik-Light_Medium", size: 36)
            view.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.94
        view.attributedText = NSMutableAttributedString(
                string: factTempText + "°",
                attributes: [NSAttributedString.Key.kern: 3.06,
                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Погодные условия
    private lazy var conditionText = String()
    private lazy var conditionLabel: UILabel = {
        var view = UILabel()
            view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
            view.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: conditionText,
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
    
    private lazy var cloudnessText = String()
    private lazy var cloudnessLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: cloudnessText,
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
    
    private lazy var windText = String()
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: windText + " м/с",
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
    
    private lazy var rainText = String()
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Light_Regular", size: 14)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(
            string: rainText + "%",
            attributes: [NSAttributedString.Key.kern: 0.14,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Время и дата прогноза
    private lazy var dateText = String()
    private lazy var dateLabel: UILabel = {
        var view = UILabel()
//        view.frame = CGRect(x: 0, y: 0, width: 151, height: 20)
        view.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        view.font = UIFont(name: "Rubik-Light_Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        view.attributedText = NSMutableAttributedString(
            string: dateText,
            attributes: [NSAttributedString.Key.kern: 0.16,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    // Пропускаем пока часть переменных (min/max, sunrise, sunset)
    
    private lazy var more24Label: UILabel = {
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemRed
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderHeight = 10
//        tableView.sectionHeaderTopPadding = 0
        
        tableView.estimatedRowHeight = 56
        tableView.layer.cornerRadius = 5
//        tableView.register(MainHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
//        tableView.register(HoursTableViewCell.self, forCellReuseIdentifier: "HoursCell")
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: "DaysCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFetchedResultsController()
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        
        setupValues()
        setupView()
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        view.addSubview(scrollView)
            scrollView.addSubview(mainView)
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
                
            scrollView.addSubview(more24Label)
            scrollView.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            mainView.heightAnchor.constraint(equalToConstant: 212),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 112),
            
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
            more24Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            more24Label.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: more24Label.bottomAnchor, constant: 24.5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func setupValues() {
        guard weatherForCity != nil else {
            factTempText = "--"
            conditionText = "Не можем получить данные"
            cloudnessText = "-"
            windText = "-"
            rainText = "-"
            // etc (ибо не уверен, что понадобится)
            return
        }
        factTempText = "\(String(describing: weatherForCity!.factTemp))"
        conditionText = weatherForCity?.factCondition ?? "Хммм... как получить данные?"
        cloudnessText = "\(String(describing: weatherForCity!.factCloudness))"
        windText = "\(String(describing: weatherForCity!.factWindSpeed))"
        rainText = "\(String(describing: weatherForCity!.factPrecProb))"
        dateText = formatDate1(unixDateToConvert: weatherForCity!.now)
        
//        let forcasts = weatherForCity?.forecasts
//        for forcast in forcasts {
//            let parts = forcast.parts
//            let daySort = parts.day_short
//        }
        
        


        print("Прогнозов для погоды в городе: \(weatherForCity?.forecasts?.count)")
    }
    
    private func formatDate1(unixDateToConvert: Int64) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixDateToConvert))
        
        // Хотим вывести такой формат:  17:48,  пт 16 апреля
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm,  E d MMMM"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        let localDate: String = dateFormatter.string(from: date as Date)
        return localDate
    }
    
    private func formatDate2(unixDateToConvert: Int64) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixDateToConvert))
        
        // Хотим вывести такой формат:  20/01
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        let localDate: String = dateFormatter.string(from: date as Date)
        return localDate
    }
}


/*
 В таблице:
    - хэдером может служить mainView, но я пока решил его сделать в контроллере, может быть потом перенесём
    - Секция 0 - лейбл-кнопка Подробнее на 24 часа
    - Секция 1 - CollectionView с почасовым прогнозом HoursTableViewCell
    - Секция 2 - или название секции? Лейбл содержащий: лейбл Ежедневный прогноз и кнопку 25 дней/7 дней
    - Секция 3 - Кастомные ячейки прогнозов по дням DaysTableViewCell
 */

/*
    Альтернатива: делать всё, кроме прогнозов в хэдере, а прогнозы - каждый в своей секции
 */


extension MainViewController: UITableViewDataSource, UITableViewDelegate {

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard section == 0 else { return nil }
//        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView {
//            view.setUserDetails(user)
//            return view
//        } else {
//            preconditionFailure("user do not exist")
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController?.sections as [NSFetchedResultsSectionInfo]? else {
            return 0
        }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section != 3 {
//            return 1
//        } else {
//            return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
//        }
        
        
//        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
        
        
//        guard let sections = fetchedResultsController?.sections else {
//          return 0
//        }
//        /*get number of rows count for each section*/
//        let sectionInfo = sections[section]
//        return sectionInfo.numberOfObjects
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysTableViewCell
            
            let object = fetchedResultsController?.object(at: indexPath)
            
            // форматируем дату
            let dateFetched = object?.dateTS ?? 0
            let dateConverted = formatDate2(unixDateToConvert: dateFetched)
            
            // определяем текст картинку для типа осадков
            let precTypeNumberFetched = object?.dayShort?.precType
            var precImage = UIImage(named: "cloudness")
            
            // Тип осадков.0 — без осадков.1 — дождь.2 — дождь со снегом.3 — снег.4 — град.
            switch precTypeNumberFetched {
            case 0:
                precImage = UIImage(named: "cloudness")
            case 1:
                precImage = UIImage(named: "cloudness")
            case 2:
                precImage = UIImage(named: "cloudness")
            case 3:
                precImage = UIImage(named: "cloudness")
            case 4:
                precImage = UIImage(named: "cloudness")
            default:
                precImage = UIImage(named: "cloudness")
            }
        
        print(object?.dayShort?.condition)
        
            
            let viewModel = DaysTableViewCell.ViewModel(
                dateText: dateConverted,
                precText: "\(String(describing: object?.dayShort?.humidity))%",
                precImage: precImage!,
                condition: object?.dayShort?.condition ?? "Привет!",
                minMaxTemp: "\(String(describing: object?.dayShort?.tempMin))°/\(String(describing: object?.dayShort?.tempMax))°")
            cell.setupValues(with: viewModel)
            
            cell.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath) as! DaysTableViewCell
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        5
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
        
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//                let vc = PhotosViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}
