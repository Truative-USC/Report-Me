//
//  adminVC.swift
//  Bully
//
//  Created by Dev on 7/9/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class adminVC: UIViewController {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var menu_vc: MenuViewController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        setupView()
    }

    @IBAction func open_menu(_ sender: Any) {
        
        if AppDelegate.menu_bool {
            show_menu()
        }
        else {
            close_menu()
        }
    }
    
    
    lazy var completed: completed = {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyBoard.instantiateViewController(withIdentifier: "completed") as! completed
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    lazy var newReports: newReports = {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyBoard.instantiateViewController(withIdentifier: "newReports") as! newReports
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var allReports: allReports = {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyBoard.instantiateViewController(withIdentifier: "allReports") as! allReports
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var inProgress: inProgressVC = {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyBoard.instantiateViewController(withIdentifier: "inProgressVC") as! inProgressVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
//    func switchStoryBoard() {
//        let storyBoard = UIStoryboard(name: "admin", bundle: nil)
//        let controller = storyBoard.instantiateViewController(withIdentifier: "admin")
//        self.present(controller, animated: true, completion: nil)
//        
//    }
    
    
    
    func show_menu() {
        
        UIView.animate(withDuration: 0.3) { ()->Void in
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
        }
        
    }
    func close_menu() {
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        }) { (finished) in
            self.menu_vc.view.removeFromSuperview()
            
        }
        AppDelegate.menu_bool = true
    }

    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            newReports.view.isHidden = true
            completed.view.isHidden = true
            allReports.view.isHidden = false
            inProgress.view.isHidden = true
        case 1:
            newReports.view.isHidden = false
            completed.view.isHidden = true
            allReports.view.isHidden = true
            inProgress.view.isHidden = true
        case 2:
            newReports.view.isHidden = true
            completed.view.isHidden = false
            allReports.view.isHidden = true
            inProgress.view.isHidden = true
        case 3:
            newReports.view.isHidden = true
            completed.view.isHidden = true
            allReports.view.isHidden = true
            inProgress.view.isHidden = false
        default:
            break;
        }
    }
    
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "New", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Completed", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "WIP", at: 3, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    
    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    
    
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
        
    }
    
    
    


}
