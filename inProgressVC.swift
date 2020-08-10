//
//  inProgressVC.swift
//  Bully
//
//  Created by Dev on 8/7/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class inProgressVC: UITableViewController {

    var inProgress = [report]()
    var reportKey: String!




    override func viewDidLoad() {
tableView.reloadData()
        tableView.contentInset.top = 70
        
        super.viewDidLoad()
        DataService.instance.reportRef.child("new").observe(.childAdded, with: { (snapshot) in

            if let dict = snapshot.value as? [String: AnyObject] {
                let wipReport = report()

                wipReport.setValuesForKeys(dict)

                if wipReport.stage == "wip" {
                    wipReport.image = #imageLiteral(resourceName: "font-awesome_4-7-0_cog_210_0_aac6d9_none")
                }
                DataService.instance.usersRef.child(wipReport.userid!).child("profile").observe(.value, with: { (user) in

                    let userDict = user.value as? NSDictionary

                    let firstName = userDict?["firstname"] as? String
                    let lastName = userDict?["lastName"] as? String
                    let schoolId = userDict?["id"] as? String

                    wipReport.userFirstName = firstName
                    wipReport.userLastName = lastName
                    wipReport.schoolID = schoolId
                    wipReport.reportKey = snapshot.key

                    if wipReport.stage == "wip" {
                        self.inProgress.insert(wipReport, at: 0)
                        self.tableView.reloadData()
                    }
                })
            }
        })

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inProgressCell = Bundle.main.loadNibNamed("adminCellTableViewCell", owner: self, options: nil)?.first as! adminCellTableViewCell
        inProgressCell.type.text = inProgress[indexPath.row].bullytype
        inProgressCell.date.text = inProgress[indexPath.row].date
        inProgressCell.name.text = inProgress[indexPath.row].userFirstName
        inProgressCell.lastName.text = inProgress[indexPath.row].userLastName
        inProgressCell.id.text = inProgress[indexPath.row].schoolID
        inProgressCell.userImage.image = inProgress[indexPath.row].image
        return inProgressCell
        
    }
    
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inProgress.count
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reportKey = inProgress[indexPath.row].reportKey
        performSegue(withIdentifier: "reportVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? reportVC {
            dest.reportID = reportKey
        }
    }
    
}
