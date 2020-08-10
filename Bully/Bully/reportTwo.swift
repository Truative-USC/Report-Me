//
//  reportTwo.swift
//  Bully
//
//  Created by Dev on 6/11/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class reportTwo: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var BullyPicker: UIPickerView!
    
   
    @IBOutlet weak var conflictDiv: UIView!
    @IBOutlet weak var conflictHeader: UILabel!
    @IBOutlet weak var conflictLogo: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!

    @IBOutlet weak var conflictBox: UITextField!
    var firstName = String()
    var firstRole = String()
    var secondName = String()
    var secondRole = String()
    var thirdName = String()
    var thirdRole = String()
    
    let bullyOptions = ["Sexual Harassment", "Cyber Bullying", "Verbal", "Physical", "Other"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        BullyPicker.dataSource = self
        BullyPicker.delegate = self

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    @IBAction func selectBtnPrsd(_ sender: Any) {
        BullyPicker.isHidden = false
    }
    
    @IBAction func stateButtonPrsd(_ sender: Any) {
        BullyPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bullyOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bullyOptions[row]
    }
    
    var currBullyType: String = ""
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currBullyType = bullyOptions[row]
        selectBtn.setTitle(bullyOptions[row], for: UIControlState.normal)
        BullyPicker.isHidden = true
        conflictBox.isHidden = false
        conflictLogo.isHidden = false
        conflictHeader.isHidden = false
        conflictDiv.isHidden = false
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            return
        }
        else {
        let nextScreen = segue.destination as! reportThree
        nextScreen.receiveBully = currBullyType
        nextScreen.receiveBullyNotes = conflictBox.text!
        nextScreen.firstName = firstName
        nextScreen.firstRole = firstRole
        nextScreen.secondName = secondName
        nextScreen.secondRole = secondRole
        nextScreen.thirdName = thirdName
        nextScreen.thirdRole = thirdRole
        
        }
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "thirdScreen", sender: self)
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
