//
//  reportThree.swift
//  Bully
//
//  Created by Dev on 6/16/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class reportThree: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var locationBtn: UIButton!
    
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var addHeader: UILabel!
    @IBOutlet weak var addLogo: UIImageView!
    @IBOutlet weak var addDivider: UIView!
    
    let locations = ["Home", "School", "Walking to/from school", "Other"]
    var sendLocation: String = ""
    var sendExtraNotes: String = ""
    var receiveBully = String()
    var receiveBullyNotes = String()
    var firstName = String()
    var firstRole = String()
    var secondName = String()
    var secondRole = String()
    var thirdName = String()
    var thirdRole = String()
    
    
    override func viewDidLoad() {
        locationPicker.dataSource = self
        locationPicker.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func locationBtnPrsd(_ sender: Any) {
        locationPicker.isHidden = false
    }

   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sendLocation = locations[row]
//        print(sendLocation)
        locationBtn.setTitle(locations[row], for: UIControlState.normal)
        locationPicker.isHidden = true
        addDivider.isHidden = false
        addLogo.isHidden = false
        addHeader.isHidden = false
        addField.isHidden = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            return
        }
        else {
        let nextScreen = segue.destination as! reportFive
        nextScreen.receiveLocation = sendLocation
        nextScreen.receiveExtraLocNotes = addField.text!
        nextScreen.receiveBullyNotes = receiveBullyNotes
        nextScreen.receiveBully = receiveBully
        nextScreen.firstName = firstName
        nextScreen.firstRole = firstRole
        nextScreen.secondName = secondName
        nextScreen.secondRole = secondRole
        nextScreen.thirdName =  thirdName
        nextScreen.thirdRole = thirdRole
            
        
        }
    }
    
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "fourthScreen", sender: self)
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func quitBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Exit", message: "All Data Will be lost", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "toHome", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
