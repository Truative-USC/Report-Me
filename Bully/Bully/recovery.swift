//
//  recovery.swift
//  Bully
//
//  Created by Dev on 6/4/17.
//  Copyright © 2017 Truative. All rights reserved.
//

import UIKit

class recovery: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var IDInput: UITextField!
    
    
    
    override func viewDidLoad() {
        submitBtn.layer.cornerRadius = 5
        submitBtn.layer.borderWidth = 1
        submitBtn.layer.borderColor = UIColor.white.cgColor
        
        emailField.leftViewMode = UITextFieldViewMode.always
        IDInput.leftViewMode = UITextFieldViewMode.always
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let emailImage = UIImage(named: "email.png")
        let emailView = imageView
        emailView.image = emailImage
        emailField.leftView = emailView
        let idView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        let idImage = UIImage(named: "idcard.png")
        idView.image = idImage
        IDInput.leftView = idView
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnPrsd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
