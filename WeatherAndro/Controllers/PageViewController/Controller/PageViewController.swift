//
//  MainViewController.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 23.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//
import UIKit

class PageViewController: UIPageViewController {
    
    var delegateScroll = [UpScrollProtocol]()
    
    // MARK: - Properties
        
    var viewControllerArray = [PageScrollViewController]()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor(red: 77.0  / 255.0, green: 59.0 / 255.0, blue: 219.0 / 255.0, alpha: 1).cgColor
        let bottomColor = UIColor(red: 121.0  / 255.0, green: 179.0 / 255.0, blue: 216.0 / 255.0, alpha: 1).cgColor
        
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.8]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Initializer
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.dataSource = self
        self.delegate = self
        setViewControllerArray()
        setViewControllers([viewControllerArray.first!], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setViewControllerArray
    
    private func setViewControllerArray() {
        let arrayCities = UserDefaults.standard.array(forKey: "Cities")
           
        //viewControllerArray.append(PageScrollViewController(type: .firstPage, cityInput: ""))
        
        // --------------------
        let temp1 = PageScrollViewController(type: .firstPage, cityInput: "Moscow", index: 0)
        let temp2 = PageScrollViewController(type: .prevCity, cityInput: "London", index: 1)
        let temp3 = PageScrollViewController(type: .prevCity, cityInput: "New York", index: 2)
        
        viewControllerArray.append(temp1)
        viewControllerArray.append(temp2)
        viewControllerArray.append(temp3)
        
        delegateScroll.append(temp1)
        delegateScroll.append(temp2)
        delegateScroll.append(temp3)
        // --------------------
        
        if let arrayCities = arrayCities {
            var index = 0
            
            for city in arrayCities {
                viewControllerArray.append(PageScrollViewController(type: .prevCity, cityInput: city as! String, index: index))
                index += 1
            }
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PageScrollViewController else {
            return nil
        }
               
        if let index = viewControllerArray.firstIndex(of: viewController) {
            if index < viewControllerArray.count - 1 {
                return viewControllerArray[index + 1]
            }
        }
            
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PageScrollViewController else {
            return nil
        }
               
        if let index = viewControllerArray.firstIndex(of: viewController) {
            if index > 0 {
                return viewControllerArray[index - 1]
            }
        }
            
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let previousViewControllers = previousViewControllers as? [PageScrollViewController] else {
            return
        }
        
        guard completed else { return }
        
        previousViewControllers.first?.setContentOffset()
    }
}
