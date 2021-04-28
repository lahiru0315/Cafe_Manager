//
//  RegisterViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {
    var firebaseauth=Auth.auth()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let email : String = self.txtEmail.text!
        let phoneNo : String = self.txtPhoneNumber.text!
        let password : String = self.txtPassword.text!
        let confirmPassword : String = self.txtConfirmPassword.text!
        
        firebaseauth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                        case .invalidEmail:
                        let  alert = UIAlertController(title: "Authentication Error", message: email + " is invalid", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        case .emailAlreadyInUse:
                        let  alert = UIAlertController(title: "Authentication Error", message: email + " is already used", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        default:
                        print("Create User Error: \(error!)")
                    }
                }
            }
            else if (phoneNo.count < 9){
                let  alert = UIAlertController(title: "Phone Number Error", message: "Phone Number must be of minimum 09 characters", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if ( password == ""){
                let  alert = UIAlertController(title: "Password Error", message: "password can not be empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if(password.count < 8){
                let  alert = UIAlertController(title: "Password Error", message: "password must be of minimum 8 characters", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if(confirmPassword != password){
                let  alert = UIAlertController(title: "Password Error", message: "Your password and confirmation password do not match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let ref = Database.database().reference()
                let userid=authResult!.user.uid
                ref.child("users/"+userid).setValue(["uid":userid,
                "phoneNo":phoneNo,"email":email])
                self.performSegue(withIdentifier: "Home", sender: self)
            }
        }
    }
}
