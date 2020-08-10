//
//  homeScreen.swift
//  Bully
//
//  Created by Dev on 6/9/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SwiftSpinner

class homeScreen: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    
    var menu_vc: MenuViewController!
    
    var menuShowing = false
    
    lazy var summaryViewController: personalUpdatesVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "personalUpdatesVC") as! personalUpdatesVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var sessionsViewController: globalUpdatesVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "globalUpdatesVC") as! globalUpdatesVC
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
  
    func switchStoryBoard() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyBoard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if AppDelegate.authUser == true {
        SwiftSpinner.show(duration: 1, title: "Authenticating User")
            AppDelegate.authUser = false
        }
        
        guard Auth.auth().currentUser != nil else {
        
          performSegue(withIdentifier: "loginVC", sender: nil)
            return
        }
        let userID = Auth.auth().currentUser?.uid
        let currUser = DataService.instance.usersRef.child(userID!)
        currUser.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let currUser = value?["profile"] as? NSDictionary
            let checkAdmin = currUser?["isAdmin"] as! String
            
            if checkAdmin == "true" {
                self.performSegue(withIdentifier: "adminVC", sender: nil)
            }
            })
    
       

    
    }
    
    
    override func viewDidLoad() {


        
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        setupView()
         super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    func respondToGesture(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            // open menu
            show_menu()
        
        case UISwipeGestureRecognizerDirection.left:
            //close menu
          close_on_swipe()  
//            close_menu()
        default:
        break;
        }
    }
    
    func close_on_swipe() {
        if AppDelegate.menu_bool {
            //show the menu
//            show_menu()
        }
        else {
            // close menu
            close_menu()
        }
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    @IBAction func menu_action(_ sender: Any) {
        //show menu
        if AppDelegate.menu_bool {
            //show the menu
            show_menu()
        }
        else {
            // close menu
            close_menu()
        }
        
    }
    
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
    
    private func updateView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            sessionsViewController.view.isHidden = false
            summaryViewController.view.isHidden = true
        
        case 1:
            sessionsViewController.view.isHidden = true
            summaryViewController.view.isHidden = false
        default:
            break;
        }
        
     }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Global", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Personal", at: 1, animated: false)
//        segmentedControl.insertSegment(withTitle: "Menu", at: 2, animated: false)
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
