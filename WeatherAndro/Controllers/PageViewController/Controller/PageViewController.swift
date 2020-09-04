//
//  MainViewController.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 23.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//
import UIKit

class PageViewController: UIPageViewController {
    
    // MARK: - Properties
        
    var viewControllerArray = [PageScrollViewController]()
    
    var delegateView = [UpScrollProtocol & HideShowArrowProtocol]()
    
    var pageControl: UIPageControl?
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupBackgroundColor()
    }
    
    // MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for subView in view.subviews {
            if subView is UIPageControl {
                pageControl = subView as? UIPageControl
            }
        }
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
    
    // MARK: - setupBackgroundColor
    
    private func setupBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor(red: 77.0  / 255.0, green: 59.0 / 255.0, blue: 219.0 / 255.0, alpha: 1).cgColor
        let bottomColor = UIColor(red: 121.0  / 255.0, green: 179.0 / 255.0, blue: 216.0 / 255.0, alpha: 1).cgColor
               
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.8]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - preferredStatusBarStyle
       
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - setViewControllerArray
    
    private func setViewControllerArray() {
        let arrayCities = UserDefaults.standard.array(forKey: "Cities")
        
        // --------------------
        let temp1 = PageScrollViewController(type: .prevCity, cityInput: "Moscow")

        temp1.delegate = self
        viewControllerArray.append(temp1)
        delegateView.append(temp1)

        delegateView.first?.hideLeftIcon()
        delegateView.last?.hideRightIcon()
        // --------------------
        
        if let arrayCities = arrayCities {
            for city in arrayCities {
                let tempViewController = PageScrollViewController(type: .prevCity, cityInput: city as? String ?? "")
                tempViewController.delegate = self
                delegateView.append(tempViewController)
                viewControllerArray.append(tempViewController)
            }
        }
        
        delegateView.first?.hideLeftIcon()
        delegateView.last?.hideRightIcon()
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension PageViewController: ViewControllerDelegate {
    func addNewCity() {
        let vc = PageScrollViewController(type: .otherPage, cityInput: "")
        vc.delegate = self
        
        viewControllerArray.append(vc)
        pageControl?.numberOfPages = viewControllerArray.count
        delegateView.last?.showRightIcon()
        delegateView.append(vc)
        delegateView.last?.hideRightIcon()
        setViewControllers([viewControllerArray.last!], direction: .forward, animated: true, completion: nil)
        pageControl?.currentPage = viewControllerArray.count - 1
    }
    
    func deleteCurrentCity() {
        if viewControllerArray.count == 1 {
            return
        }
        
        let currentPage = pageControl!.currentPage
        var prevPage: Int
        
        var arrayCities = UserDefaults.standard.array(forKey: "Cities") as! [String]
        
        if currentPage == 0 {
            prevPage = 1
            delegateView[1].hideLeftIcon()
            
            if arrayCities.count > 0 {
                arrayCities.remove(at: 0)
            }
        } else {
            if currentPage == viewControllerArray.count - 1 {
                delegateView[currentPage - 1].hideRightIcon()
            }
            
            prevPage = currentPage - 1
            
            if arrayCities.count > 0 {
                arrayCities.remove(at: currentPage - 1)
            }
        }
        
        UserDefaults.standard.set(arrayCities, forKey: "Cities")
        
        setViewControllers([viewControllerArray[prevPage]], direction: .forward, animated: true, completion: nil)
        viewControllerArray.remove(at: currentPage)
        delegateView.remove(at: currentPage)
        pageControl?.numberOfPages = viewControllerArray.count
        pageControl?.currentPage = prevPage
    }
}
