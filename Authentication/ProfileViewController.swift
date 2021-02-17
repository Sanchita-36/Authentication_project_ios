//
//  ProfileViewController.swift
//  Authentication
//
//  Created by Mac on 17/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.usernameLB.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func selectOptions(_ sender: UIBarButtonItem) {
        actionSheetAlert()
    }
    //actionsheet code
    func actionSheetAlert(){
        let menu = UIAlertController.init(title: "Options", message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Logout", style: .default) { (UIAlertAction) in
            self.logOut()
        }
        let changepassword = UIAlertAction(title: "Change Passsword", style: .default) { (UIAlertAction) in
            self.changePasswordBT()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(logout)
        menu.addAction(changepassword)
        menu.addAction(cancel)
        self.present(menu, animated: true, completion: nil)
        
    }
    // firebase logout code
    func logOut(){
        try! Auth.auth().signOut()
       UserDefaults.standard.removeObject(forKey: "isStudent")
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")as!LoginViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
    // change password button
    func changePasswordBT(){
        let viewc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        let nav = UINavigationController(rootViewController: viewc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }

}
