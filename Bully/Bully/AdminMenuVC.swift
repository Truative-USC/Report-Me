//
//  AdminMenuVC.swift
//  Bully
//
//  Created by Dev on 7/10/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class AdminMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menu_tableView: UITableView!

    let title_arr = ["Home", "Profile", "Settings", "Payment", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_tableView.delegate = self
        menu_tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell" ) as! MenuTableViewCell
        cell.label_title.text = title_arr[indexPath.row]
        return cell
        
        
    }

}
