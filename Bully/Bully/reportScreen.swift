//
//  reportScreen.swift
//  Bully
//
//  Created by Dev on 6/9/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class reportScreen: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var roleInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var quitButn: UIButton!
    @IBOutlet weak var secondRole: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var thirdNAme: UITextField!
    @IBOutlet weak var thirdRole: UITextField!
    override func viewDidLoad() {
        
        nameInput.delegate = self
        roleInput.delegate = self        
        super.viewDidLoad()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "secondSeg", sender: self)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            return
        }
        else {
            let finalScreen = segue.destination as! reportTwo
            finalScreen.firstName = nameInput.text!
            finalScreen.firstRole = roleInput.text!
            finalScreen.secondName = secondName.text!
            finalScreen.secondRole = secondRole.text!
            finalScreen.thirdName = thirdNAme.text!
            finalScreen.thirdRole = thirdRole.text!
            
        }
    }
        
    

   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameInput {
            textField.resignFirstResponder()
        }
        if textField == self.roleInput {
            textField.resignFirstResponder()
        }
        
        return true
    }
  
}
