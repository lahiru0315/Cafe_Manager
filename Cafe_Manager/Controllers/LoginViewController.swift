//
//  LoginViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let authentication = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func btnLogin(_ sender: UIButton) {
        let email : String = self.txtEmail.text!
        let password : String = self.txtPassword.text!
        let result:Bool = CheckEmail.isValidEmail(email:email)
        
        if !result{
            let  alert = UIAlertController(title: "ERROR", message: "please check the Email Address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if ( password == "" ){
                let  alert = UIAlertController(title: "ERROR", message: "password is can not be empty!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        else{
                authentication.signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                let  alert = UIAlertController(title: "ERROR", message: "Invalid Email or Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                }
                    
                else if let errr=error{
                    print(errr)
                }
                else{
                    self.performSegue(withIdentifier: "Home", sender: self)
                }
                }
        }
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Register", sender: self)
    }
    
    @IBAction func btnForgetPassword(_ sender: UIButton) {
         self.performSegue(withIdentifier: "ForgetPassword", sender: self)
    }
}
