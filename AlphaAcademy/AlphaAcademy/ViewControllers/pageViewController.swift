//
//  pageViewController.swift
//  AlphaAcademy
//
//  Created by Tengoku no Spoa on 2017/7/20.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class pageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    /**
     * The UIPageControl class
     */
    var pageControl = UIPageControl()
        
    /**
     * Defines the UIView Container
     */
    lazy var orderedViewControllers: [UIViewController] = {
        return []
    }()
    

    /**
     * Defines the whole list of additional UIViews
     */
    lazy var additionalViewControllers: [UIViewController] = {
        return [
            self.newVc(viewController: "Chapter1"),
            self.newVc(viewController: "Chapter2"),
            self.newVc(viewController: "Chapter3"),
            self.newVc(viewController: "Chapter4"),
            self.newVc(viewController: "Chapter5"),
            self.newVc(viewController: "Chapter6"),
            self.newVc(viewController: "Chapter7")
        ]
    }()
    
    
    /**
     *
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // connects to data source
        self.dataSource = self
        self.delegate = self
        
        // configure pageControlDataSouce
        configureDataSource()
        configurePageControl()
    }
    
    /**
     * This function appends additional ViewControllers into orederedViewControllerts according to user's Level
     */
    func configureDataSource() {
        // combine additional View Controllers according to user's level
        if let userLevel = UserDefaults.standard.object(forKey: "userLevel") as? Int {
            
            var level = userLevel>7 ? 7 : userLevel
            level = userLevel<0 ? 0 : userLevel
            if level != 0 {
                for i in 0...level-1 {
                    orderedViewControllers.append(additionalViewControllers[i])
                }
            } else {
                orderedViewControllers.append(additionalViewControllers[0])
            }
        }
        
        // add userInfoPage
        orderedViewControllers.append(self.newVc(viewController: "UserInformation"))
        
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    
    /**
     * This function configures the PageControl
     */
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    /**
     * This function instantiatie and returns a view Controller
     *
     * @param viewController the string identifier of the view controller that is passed in
     * @return an UIViewController according to the identifer passed in
     */
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    /**
     * Page View Delegate
     */
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    /**
     * Page View Data Source
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
}
