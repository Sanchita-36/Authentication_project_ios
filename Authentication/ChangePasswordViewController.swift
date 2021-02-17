//
//  ChangePasswordViewController.swift
//  Authentication
//
//  Created by Mac on 17/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newPasswordAgainTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dissmis))
    }
    @objc func dissmis(){
        self.dismiss(animated: true)
    }

    @IBAction func resetBtn(_ sender: UIButton) {
        valiDate()
    }
    
    //validation code for reset password
    func valiDate(){
        if (newPasswordTF.text == newPasswordAgainTF.text ){
            loginAgain()
        }else{
            self.showAlert(title: "Incorrect Password", message: "Password did not match")
        }
    }
    // in this code we are check current pass word and enter current password is sanme of not in backend if password is right then chage password
    func loginAgain(){
        let users = Auth.auth().currentUser
        Auth.auth().signIn(withEmail:(users?.email)!, password: currentPasswordTF.text!) { authresult, error in
            if let error = error {
                self.showAlert(title: "Incorrect Password", message: "please enter correct password")
                print("login not sucessfull"+error.localizedDescription)
            } else{
                self.changePassword()
            }
        }
    }
    
    // show action sheet
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //firebase change password code
    func changePassword(){
        let user = Auth.auth().currentUser
        let newpassword = newPasswordTF.text
        user?.updatePassword(to: newpassword!, completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Password changed.
                print("Password changed")
            }
        })
    }
}
