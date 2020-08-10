//
//  reportSix.swift
//  Bully
//
//  Created by Dev on 6/30/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class reportSix: UIViewController {

    @IBOutlet weak var thirdRole: UILabel!
    @IBOutlet weak var thirdName: UILabel!
    @IBOutlet weak var secondRole: UILabel!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var firstRole: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var recieveLocation: UILabel!
    @IBOutlet weak var locationNotes: UILabel!
    @IBOutlet weak var bullyTypeLabel: UILabel!
    @IBOutlet weak var bullyNoteLabel: UILabel!
    @IBOutlet weak var extraInfo: UILabel!
    
    var currString = String()
    var receiveLoc = String()
    var recieveLocNotes = String()
    var bullyType = String()
    var bullyNotes = String()
    var sendfirstName = String()
    var sendfirstRole = String()
    var sendsecondName = String()
    var sendsecondRole = String()
    var sendthirdName = String()
    var sendthirdRole = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extraInfo.text = currString
        recieveLocation.text = receiveLoc
        locationNotes.text = recieveLocNotes
        bullyTypeLabel.text = bullyType
        bullyNoteLabel.text = bullyNotes
        firstRole.text = sendfirstRole
        firstName.text = sendfirstName
        secondName.text = sendsecondName
        secondRole.text = sendsecondRole
        thirdName.text = sendthirdName
        thirdRole.text = sendthirdRole
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func submitReport(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
//        let date = NSDate(timeIntervalSince1970: interval)
        
        let report: Dictionary<String, AnyObject> = ["bullytype": bullyType as AnyObject, "bullynote": bullyNotes as AnyObject, "bullylocation": receiveLoc as AnyObject, "locationnotes": recieveLocNotes as AnyObject, "date": currString as AnyObject, "firstUser": sendfirstName as AnyObject, "firstUserRole": sendfirstRole as AnyObject, "secondUser": sendsecondName as AnyObject, "secondUserRole": sendsecondRole as AnyObject, "thirdUser": sendthirdName as AnyObject, "thirdUserRole": sendthirdRole as AnyObject, "userid": userID as AnyObject, "stage" : "new" as AnyObject]
        DataService.instance.reportRef.child("new").childByAutoId().setValue(report)
        
        self.performSegue(withIdentifier: "toHome", sender: self)
        
    }

}
