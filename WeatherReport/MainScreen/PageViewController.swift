//
//  PageViewController.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/15/23.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    private var pageController: UIPageViewController!
    private var controllers = [UIViewController]()
    private var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupPageController(with: "Current Location")
        setupPageControl()
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Rubik-Light_Medium", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)]
        
        let leftButton = UIButton(type: .custom)
            leftButton.frame = CGRect(x: 0.0, y: 0.0, width: 36, height: 20)
            leftButton.setImage(UIImage(named:"settingsButton"), for: .normal)
            leftButton.addTarget(self, action: #selector(editUserSettings), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftButton)
        let leftWidth = leftItem.customView?.widthAnchor.constraint(equalToConstant: 36)
            leftWidth?.isActive = true
        let leftHeight = leftItem.customView?.heightAnchor.constraint(equalToConstant: 20)
            leftHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightButton = UIButton(type: .custom)
            leftButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 26)
            rightButton.setImage(UIImage(named:"locationButton"), for: .normal)
            rightButton.addTarget(self, action: #selector(getNewLocationWeather), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: rightButton)
        let rightWidth = rightItem.customView?.widthAnchor.constraint(equalToConstant: 20)
            rightWidth?.isActive = true
        let rightHeight = rightItem.customView?.heightAnchor.constraint(equalToConstant: 26)
            rightHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    
    private func setupPageController(with cityName: String) {
        pageController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        pageController.dataSource = self
        pageController.delegate = self
            
        addChild(pageController)
        view.addSubview(pageController.view)

        let views = ["pageController": pageController.view] as [String: AnyObject]
        
        view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[pageController]|",
                options: [],
                metrics: nil,
                views: views)
        )
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[pageController]|",
            options: [],
            metrics: nil,
            views: views)
        )
        
        createControllers(with: cityName)
        
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
    }
    
    
    private func createControllers(with cityName: String) {
        let weathers = CoreDataManager.defaultManager.getCoreDataCash()
        guard !(weathers?.isEmpty ?? true) else {
            
            print("В базе нет данных")
            
            let vc = MainViewController()
            vc.weather = nil
            vc.title = "Добавьте первую локацию"
            
            controllers.insert(vc, at: 0)
            
            return
        }
        for weather in weathers! {
            let vc = MainViewController()
            vc.weather = weather
            vc.title = weather.cityName
            
            controllers.insert(vc, at: 0)           // что-бы сразу показывать этот элемент
        }
    }
    
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.minY + 74,
            width: UIScreen.main.bounds.width,
            height: 50)
        )
        self.pageControl.numberOfPages = controllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    @objc
    private func editUserSettings() {
        let vc = SettingsViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc
    private func getNewLocationWeather() {
        print("getNewLocationWeather")
        
        /*
         При нажатии на эту кнопку должен появиться UIAlertController с возможностью ввода города.
         После ввода и нажатия на кнопку ок, необходимо перевести название города в координаты - это необходимо, так как большинство погодных сервисов принимают на вход пару координат - долготу и широту. Это легче всего делать с помощью сервиса - https://yandex.ru/dev/maps/geocoder/
         */
         
         // 1 + getCityNameFromUser
         
        TextPicker.defaultPicker.showPicker(in: self, withMessage: "Введите название города") { text in
            let cityName = text
            
            // 2 + getLocationFromCityName
            
            getLocationFromCityName(cityName: cityName) { latLongArray, errorString in
                guard latLongArray != nil else {
                    return
                }
                
                guard let latitudeString = latLongArray?[1], let longitudeString = latLongArray?[0] else {
                    print("не приходят координаты")
                    return
                }
                
                let latitude = Float(latitudeString)!
                let longitude = Float(longitudeString)!
                
                let locationName = latLongArray?[2]
                
                // 3 + getWeatherFromLocation
                
                downloadWeatherInfo(lat: latitude, lon: longitude) { weather, errorString in
                    
                    guard weather != nil else {
                        print("Данные о погоде почему-то не приходят")
                        return
                    }
                    
                    // 4 + addWeatherToCoreData
                    
                    CoreDataManager.defaultManager.setCoreDataCash(weather: weather!, locationName: locationName ?? "Unknown location") {
                        
                        // 5 + update Views, set title &  6 - sroll to new VC
                        
                        DispatchQueue.main.async {
                            self.controllers = []
                            self.pageController.dataSource = nil
                            self.pageController.delegate = nil
                            self.setupPageController(with: locationName!)
                            self.setupPageControl()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.lastIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.lastIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    // MARK: Delegate functions
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {

        let pageContentViewController = pageViewController.viewControllers![0]
        self.title = pageContentViewController.navigationItem.title
//        self.navigationController?.navigationBar.topItem?.title = pageContentViewController.navigationItem.title
        self.pageControl.currentPage = controllers.lastIndex(of: pageContentViewController)!
    }
}
