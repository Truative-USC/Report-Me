//
//  PageVC.swift
//  Bully
//
//  Created by Dev on 6/10/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "reportOne"),
               self.VCInstance(name: "reportTwo"),
               self.VCInstance(name: "reportThree"),
               self.VCInstance(name: "reportFour"),
               self.VCInstance(name: "reportFive")]
    }()
    
    private func VCInstance(name: String)->UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let reportOne = VCArray.first {
            setViewControllers([reportOne], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
        return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return VCArray.last
        }
        
        guard VCArray.count > previousIndex else {
            return nil
        }
        return VCArray[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < VCArray.count else {
            return VCArray.first
        }
        
        guard VCArray.count > nextIndex else {
            return nil
        }
        return VCArray[nextIndex]

    }
    
    
     public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
        
    }
     public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first,
        let firstVCIndex = VCArray.index(of: firstVC) else {
            return 0
        }
        return firstVCIndex
    }
    
}
