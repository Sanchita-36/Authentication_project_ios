//
//  Student_TabBarViewController.swift
//  Authentication
//
//  Created by Mac on 04/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class Authentication_TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
          configureTabbar()  //- in view did load
    }
    
   func configureTabbar()   //- outside view did load
   {
        self.tabBar.tintColor = .red
        self.tabBar.isTranslucent = true
   }
}

