//
//  newReports.swift
//  Bully
//
//  Created by Dev on 8/1/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class newReports: UITableViewController {


    var newReports = [report]()
    var reportKey: String!

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()

        tableView.contentInset.top = 0

        DataService.instance.reportRef.child("new").observe(.childAdded, with: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {

                let newReport = report()

                newReport.setValuesForKeys(dictionary)


                DataService.instance.usersRef.child(newReport.userid!).child("profile").observe(.value, with: { (reportSnap) in
                    let userProfile = reportSnap.value as? NSDictionary

                    let userFirsName = userProfile?["firstname"] as? String
                    let userLastName = userProfile?["lastName"] as? String
                    let schoolId = userProfile?["id"] as? String
                    newReport.reportKey = snapshot.key
                    newReport.userFirstName = userFirsName
                    newReport.userLastName = userLastName
                    newReport.schoolID = schoolId

                    if newReport.stage == "new" {
                        newReport.image = #imageLiteral(resourceName: "font-awesome_4-7-0_clock-o_143_0_69ff00_none")
                    }



                    if newReport.stage == "new" {
                        self.newReports.insert(newReport, at: 0)
                        self.tableView.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newReports.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let newReportCell = Bundle.main.loadNibNamed("adminCellTableViewCell", owner: self, options: nil)?.first as! adminCellTableViewCell
        newReportCell.type.text = newReports[indexPath.row].bullytype
        newReportCell.date.text = newReports[indexPath.row].date
        newReportCell.name.text = newReports[indexPath.row].userFirstName
        newReportCell.lastName.text = newReports[indexPath.row].userLastName
        newReportCell.id.text = newReports[indexPath.row].schoolID
        newReportCell.userImage.image = newReports[indexPath.row].image
        return newReportCell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reportKey = newReports[indexPath.row].reportKey
        performSegue(withIdentifier: "reportVC", sender: nil)


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let Dest = segue.destination as? reportVC {
            Dest.reportID = reportKey
        }
    }
}
