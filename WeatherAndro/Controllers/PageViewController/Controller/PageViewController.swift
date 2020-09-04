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
    
    var pageControl: UIPageControl?
        
    var viewControllerArray = [PageScrollViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for subView in view.subviews {
            if subView is UIPageControl {
                pageControl = subView as? UIPageControl
                //subView.isHidden = true
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
    
    // MARK: - setViewControllerArray
    
    private func setViewControllerArray() {
        let arrayCities = UserDefaults.standard.array(forKey: "Cities")
           
        //viewControllerArray.append(PageScrollViewController(type: .firstPage, cityInput: ""))
        
        // --------------------
        let temp1 = PageScrollViewController(type: .firstPage, cityInput: "Moscow")
        let temp2 = PageScrollViewController(type: .prevCity, cityInput: "London")
        
        viewControllerArray.append(temp1)
        viewControllerArray.append(temp2)
        
        delegateScroll.append(temp1)
        delegateScroll.append(temp2)
        // --------------------
        
        if let arrayCities = arrayCities {
            for city in arrayCities {
                viewControllerArray.append(PageScrollViewController(type: .prevCity, cityInput: city as! String))
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let previousViewControllers = previousViewControllers as? [PageScrollViewController] else {
            return
        }
        
        guard completed else { return }
        
        previousViewControllers.first?.setContentOffset()
    }
}
