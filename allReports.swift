//
//  allReports.swift
//  Bully
//
//  Created by Dev on 8/1/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class allReports: UITableViewController {

    var reports = [report]()
    var reportKey: String!
    
    
    
    
    override func viewDidLoad() {
        tableView.reloadData()
        super.viewDidLoad()
        
//        var testReport: report =
        
        self.automaticallyAdjustsScrollViewInsets = true
        tableView.contentInset.top = 70
        
        
        
        DataService.instance.reportRef.child("new").observe(.childAdded, with: { (snapshot) in
            
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let newReport = report()
                newReport.setValuesForKeys(dictionary)
                
                if newReport.stage == "new" {
                    newReport.image = #imageLiteral(resourceName: "font-awesome_4-7-0_clock-o_143_0_69ff00_none")
                }
                if newReport.stage == "completed" {
                    newReport.image = #imageLiteral(resourceName: "font-awesome_4-7-0_check-circle-o_143_0_3300ff_none")
                }
                    
                var firstName: String?
                
                DataService.instance.usersRef.child(newReport.userid!).child("profile").observe(.value, with: { (dataSnap) in
                    
                   let value = dataSnap.value as? NSDictionary
                
                     firstName = value?["firstname"] as? String
                    let lastName = value?["lastName"] as! String
                    let id = value?["id"] as! String
                    
                    newReport.userFirstName = firstName
                    newReport.reportKey = snapshot.key
                    newReport.userLastName = lastName
                    newReport.schoolID = id
                    self.reports.insert(newReport, at: 0)
                    self.tableView.reloadData()
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return reports.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows

        let cell = Bundle.main.loadNibNamed("adminCellTableViewCell", owner: self, options: nil)?.first as! adminCellTableViewCell
        cell.type.text = reports[indexPath.row].bullytype
        cell.date.text = reports[indexPath.row].date
        cell.name.text = reports[indexPath.row].userFirstName
        cell.lastName.text = reports[indexPath.row].userLastName
        cell.id.text = reports[indexPath.row].schoolID
        cell.userImage.image = reports[indexPath.row].image
        return cell
    
    
    
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reportKey = reports[indexPath.row].reportKey
        performSegue(withIdentifier: "reportVC", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? reportVC {
            destinationVC.reportID = reportKey
            
            
            
        }
        
    }
    
   
}
