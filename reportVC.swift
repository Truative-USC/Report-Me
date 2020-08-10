//
//  reportVC.swift
//  Bully
//
//  Created by Dev on 8/7/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class reportVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var stagePicker: UIPickerView!
    var reportID: String!

    @IBOutlet weak var changeStage: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    
    @IBOutlet weak var roleTwo: UILabel!
    @IBOutlet weak var roleThree: UILabel!
    @IBOutlet weak var thirdStudent: UILabel!
    @IBOutlet weak var secondStudent: UILabel!
    @IBOutlet weak var locatino: UILabel!
    @IBOutlet weak var firstUserType: UILabel!
    @IBOutlet weak var firstStudent: UILabel!
    @IBOutlet weak var locationNote: UILabel!
    @IBOutlet weak var bullyNote: UILabel!
    let currReport = report()
    
    let stageoptions = ["completed", "wip", "new"]
    
    override func viewDidLoad() {
        stagePicker.dataSource = self
        stagePicker.delegate = self
        label.text = reportID
        
        
        DataService.instance.reportRef.child("new").child(reportID!).observe(.value, with: { (snapshot) in
            
            let dict = snapshot.value as? NSDictionary
            
           self.userFirstName.text =  dict?.value(forKey: "bullytype") as? String
            self.dateLabel.text = dict?.value(forKey: "date") as? String
            self.bullyNote.text = dict?.value(forKey: "bullynote") as? String
            self.locationNote.text = dict?.value(forKey: "locationnotes") as? String
            self.firstStudent.text = dict?.value(forKey: "firstUser") as? String
            self.firstUserType.text = dict?.value(forKey: "firstUserRole") as? String
            self.locatino.text = dict?.value(forKey: "bullylocation") as? String
            self.roleTwo.text = dict?.value(forKey: "secondUserRole") as? String
            self.roleThree.text = dict?.value(forKey: "thirdUserRole") as? String
            self.secondStudent.text = dict?.value(forKey: "secondUser") as? String
            self.thirdStudent.text = dict?.value(forKey: "thirdUser") as? String
            
        })
        
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changePickerView(_ sender: Any) {
        if stagePicker.isHidden == true {
            stagePicker.isHidden = false
        }
        else {
            stagePicker.isHidden = true
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stageoptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stageoptions[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let newStage: String = stageoptions[row]
        
        DataService.instance.reportRef.child("new").child(reportID!).updateChildValues(["stage" : newStage])
        
        stagePicker.isHidden = true
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? changeStage {
            dest.reportID = reportID
        }
        if let desttwo = segue.destination as? notesVC {
            desttwo.reportID = reportID
        }
        
    }
    
}
