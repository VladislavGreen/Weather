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
        setupPageController()
        
        self.delegate = self
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
    
    
    private func setupPageController() {
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
        
        createControllers()

        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
    }
    
    
    private func createControllers() {
        let weathers = CoreDataManager.defaultManager.getCoreDataCash()
        guard weathers != nil else {
            print("В базе нет данных")
            return }
        for weather in weathers! {
            let vc = MainViewController()
            vc.weatherForCity = weather
            navigationItem.title = weather.cityName
            controllers.append(vc)
        }
    }
    
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.minY + 74,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = controllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    @objc
    private func editUserSettings() {
        print("editUserSettings")
    }
    
    @objc
    private func getNewLocationWeather() {
        print("getNewLocationWeather")
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    // MARK: Delegate functions
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = controllers.firstIndex(of: pageContentViewController)!
       }
    
}
