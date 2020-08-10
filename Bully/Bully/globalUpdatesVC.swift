//
//  globalUpdatesVC.swift
//  Bully
//
//  Created by Dev on 7/24/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class globalUpdatesVC: UITableViewController {

   
    
    var reports = [report]()

    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var bullyLabel: UILabel!
    
    
    
//    func postReport() {
//        let bullyLocation = "City"
//        let bullType = "Bully Type"
//        
//        let report: [String: AnyObject] = ["bullylocation" : bullyLocation, "bullytype" : bullType]
//        
//        
//        DataService.instance.reportRef.child("new").
//    }
    
    
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = true
       
        
        
        
        
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
                
                
                
                self.reports.insert(newReport, at: 0)
                self.tableView.reloadData()
                
            }
            
            
            
        })
        
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = Bundle.main.loadNibNamed("reportCell", owner: self, options: nil)?.first as! reportCell
        cell.reportStage.image = reports[indexPath.row].image
        cell.locationLabel.text = reports[indexPath.row].bullylocation
        cell.bullyType.text = reports[indexPath.row].bullytype
        cell.date.text = reports[indexPath.row].date
        cell.stage.text = reports[indexPath.row].stage
        return cell
    
    
    
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
