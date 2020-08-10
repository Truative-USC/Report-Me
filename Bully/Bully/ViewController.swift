
//
//  ViewController.swift
//  Bully
//
//  Created by Dev on 5/29/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!


//    override func viewDidAppear(_ animated: Bool) {
//            let keychain = DataService().keyChain
//        if keychain.get("uid") != nil {
//            performSegue(withIdentifier: "goHome", sender: nil)
//        }
//    }
//

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
   
    
    

    override func viewDidLoad() {
        
        loginButton.layer.cornerRadius = 5
        userInput.leftViewMode = UITextFieldViewMode.always
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        passwordInput.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let passView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let passImage = UIImage(named: "lock.png")
        let image = UIImage(named: "usr.png")
        passView.image = passImage
        passwordInput.leftView = passView
        imageView.image = image
        userInput.leftView = imageView
        userInput.delegate = self
        passwordInput.delegate = self

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userInput {
            textField.resignFirstResponder()
        }
        if textField == self.passwordInput {
            textField.resignFirstResponder()
        }

        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func loginBtn(_ sender: Any) {
        

        if let email = userInput.text, let pass = passwordInput.text, (email.characters.count > 0 && pass.characters.count > 0) {
            AuthService.instance.login(email: email, password: pass, onComplete: {(errMsg, data) in
                guard errMsg == nil else {
                        let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let userID = Auth.auth().currentUser?.uid
//                var checkAdmin: Bool = false
                let currUser = DataService.instance.usersRef.child(userID!)
//                let admin = ""
                currUser.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let currUser = value?["profile"] as? NSDictionary
                    let checkAdmin = currUser?["isAdmin"] as! String
                    
                    if checkAdmin  == "true" {
                        print("Went Admin")
                        self.performSegue(withIdentifier: "goAdmin", sender: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "goHome", sender: nil)
                    }
                    
                   
                    })                
                
            })
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Invalid Username/Password", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction((UIAlertAction(title: "Ok", style: .default)))
                self.present(alert, animated: true, completion: nil)
                return
        }




    }
    
    
    
    //                DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
    //
    //                    if let users = snapshot.value as? Dictionary<String, AnyObject> {
    //                        for(key, value) in users {
    //                            if let dict = value as? Dictionary<String, AnyObject> {
    //                                if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
    //                                    if let admin = profile["isAdmin"] as? String {
    //                                        let uid = key
    //                                        let user = User(uid: uid, firstName: firstName)
    //                                        self.users.append(user)
    //                                    }
    //                                }
    //                            }
    //                        }
    //                    }
    //
    //                    
    //                })

   

    
    
    //        let email = userInput.text
    //        let password = passwordInput.text
    //
    //
    //        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
    //            if error == nil {
    //                Database.database().reference().child("users/\(user!.uid)/type").observeSingleEvent(of: .value, with: {
    //                    (snapshot) in
    //                    swich snapshot.value as! String {
    //
    //                        case "admin":
    //                        //
    //
    //                    }
    //                })
    //            }
    //        }
    
    
    
    
    
    
    
    




//    if let email = userInput.text, let password = passwordInput.text {
//        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
//            if let firebaseError = error {
//                let alert = UIAlertController(title: "Error", message: "Invalid Username/Password", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction((UIAlertAction(title: "Ok", style: .default)))
//                self.present(alert, animated: true, completion: nil)
//                print(firebaseError.localizedDescription)
//                return
//            }
//            else {
//                self.performSegue(withIdentifier: "goHome", sender: nil)
//            }
//        })
//
//    }

    //        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "homeScreen") as! homeScreen
    //        let navControll = UINavigationController(rootViewController: VC1)
    //        self.present(navControll, animated: true, completion: nil)


//    func userLoggedIn() {
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loggedInVC:homeScreen = storyboard.instantiateViewController(withIdentifier: "homeScreen") as! homeScreen
//        self.present(loggedInVC, animated: true, completion: nil)
//
//    }
//



}

























//
//    func CompleteSignIn(id: String) {
//        let keyChain = DataService().keyChain
//
//        keyChain.set(id, forKey: "uid")
//    }
//
//    @IBAction func SignIn(_ sender: Any) {
//        if let email = userInput.text, let password = passwordInput.text, (email.characters.count > 0 && password.characters.count > 0) {
//
//            AuthService.instance.login(email: #imageLiteral(resourceName: "email"), password: password, onComplete: { (errMsg, data) in
//                <#code#>
//            })
//            //                if error == nil {
////                    self.CompleteSignIn(id: user!.uid)
////                    self.performSegue(withIdentifier: "SignIn", sender: nil)
////
//              }
//                else {
//                    let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//
////                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
////                        if error != nil {
////                            print("cannot sign user in")
////                        }
////                        else {
////                            self.CompleteSignIn(id: user!.uid)
////                            self.performSegue(withIdentifier: "SignIn", sender: nil)
////                        }
//                    }
//                }
//
//
//

