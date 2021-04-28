//
//  ForgetPasswordViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ForgetPasswordViewController: UIViewController {

    let authentication = Auth.auth()
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()

    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        let emailText=txtEmail.text!;
        let ckresult:Bool = CheckEmail.isValidEmail(email:emailText)
        if !ckresult{
            let  alert = UIAlertController(title: "Email Error", message: "please type valid Email Address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
                                    }
        else{
            Auth.auth().sendPasswordReset(withEmail: emailText) {
            error in
            self.performSegue(withIdentifier: "Login", sender: self)
                
            let  alert = UIAlertController(title: "Reset link has been Sent", message: "If you can not find your reset link  in your  inbox, it is worth checking in your spam or junk mail section.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
