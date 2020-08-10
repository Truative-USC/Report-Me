//
//  firstTime.swift
//  Bully
//
//  Created by Dev on 5/29/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import FirebaseDatabase
import KeychainSwift
import FirebaseAuth

class firstTime: UIViewController {

    @IBOutlet weak var authCodeInput: UITextField!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passInput: UITextField!
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    override func viewDidLoad() {
        
        createBtn.layer.cornerRadius = 5
        createBtn.layer.borderWidth = 1
        createBtn.layer.borderColor = UIColor.white.cgColor
        
        authCodeInput.leftViewMode = UITextFieldViewMode.always
        userInput.leftViewMode = UITextFieldViewMode.always
        passInput.leftViewMode = UITextFieldViewMode.always
        idInput.leftViewMode = UITextFieldViewMode.always
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let authView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let authImage = UIImage(named: "qrcode.png")
        authView.image = authImage
        authCodeInput.leftView = authView
        let userView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let userImage = UIImage(named: "usr.png")
        userView.image = userImage
        userInput.leftView = userView
        let passView = imageView
        let passImage = UIImage(named: "lock.png")
        passView.image = passImage
        passInput.leftView = passView
        let idView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let idImage = UIImage(named: "idcard.png")
        idView.image = idImage
        idInput.leftView = idView
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createBtnPrsd(_ sender: Any) {
        if userInput.text == "" || passInput.text == "" || authCodeInput.text == "" {
            let alert = UIAlertController(title: "Error Creating User", message: "Please fill in All Fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            if let email = userInput.text, let password = passInput.text, let firstName = authCodeInput.text, let id = idInput.text {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let fireBaseerr = error {
                        let authError = UIAlertController(title: "Error", message: "Error Creating User. Please try again", preferredStyle: UIAlertControllerStyle.alert)
                        authError.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(authError, animated: true, completion: nil)
                    }
                    else {
                        DataService.instance.saveUser(uid: user!.uid, userFirstName: firstName, userID: id)
                        self.performSegue(withIdentifier: "newGoHome", sender: nil)
                    }
                })
                
            }
            
            
            
            
            
            
            
            
            
            
            
        }
    }
    
    
   
    
    
    
    
    
    
    
    
    

}
