//
//  spinnerVC.swift
//  Bully
//
//  Created by Dev on 7/20/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import SwiftSpinner


class spinnerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show(progress: 0.2, title: "Downloading Data...")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
