//
//  completedReportsTableViewController.swift
//  Bully
//
//  Created by Dev on 8/4/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class completed: UITableViewController {

    var completedReports = [report]()
    var reportKey: String!






    override func viewDidLoad() {
tableView.reloadData()
        super.viewDidLoad()

        tableView.contentInset.top = 70



        DataService.instance.reportRef.child("new").observe(.childAdded, with: { (snapshot) in

            if let dict = snapshot.value as? [String: AnyObject] {
                let completedReport = report()

                completedReport.setValuesForKeys(dict)

                if completedReport.stage == "completed" {
                    completedReport.image = #imageLiteral(resourceName: "font-awesome_4-7-0_check-circle-o_143_0_3300ff_none")

                }

                DataService.instance.usersRef.child(completedReport.userid!).child("profile").observe(.value, with: { (userSnap) in
                    let userDict = userSnap.value as? NSDictionary

                    let userFirsName = userDict?["firstname"] as? String
                    let userLastName = userDict?["lastName"] as? String
                    let userSchoolId = userDict?["id"] as? String
                    completedReport.userFirstName = userFirsName
                    completedReport.userLastName = userLastName
                    completedReport.schoolID = userSchoolId
                    completedReport.reportKey = snapshot.key
                    if completedReport.stage == "completed" {
                        self.completedReports.insert(completedReport, at: 0)
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


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedReports.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completedCell = Bundle.main.loadNibNamed("adminCellTableViewCell", owner: self, options: nil)?.first as! adminCellTableViewCell
        completedCell.type.text = completedReports[indexPath.row].bullytype
        completedCell.date.text = completedReports[indexPath.row].date
        completedCell.name.text = completedReports[indexPath.row].userFirstName
        completedCell.lastName.text = completedReports[indexPath.row].userLastName
        completedCell.id.text = completedReports[indexPath.row].schoolID
        completedCell.userImage.image = completedReports[indexPath.row].image
        return completedCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reportKey = completedReports[indexPath.row].reportKey
        performSegue(withIdentifier: "reportVC", sender: nil)

    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? reportVC {
            dest.reportID = reportKey
        }

    }

}
