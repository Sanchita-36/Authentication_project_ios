//
//  Switcher.swift
//  Authentication
//
//  Created by Mac on 02/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    var table = HomeViewController()
    
    static func updateRootVC(){
        //Note:UserDefaults is used to store small data
        
        let status = UserDefaults.standard.bool(forKey: "status") // To retrieve data
        var rootVC : UIViewController?
        print(status)
        
        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Authentication_TabBarViewController") as! Authentication_TabBarViewController
            
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        }
        
        //For Scene delegate. Code added to show the screens as per users login logout status
        let window = UIApplication.shared.windows.first
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
}
