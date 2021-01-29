//
//  CreateBatchViewController.swift
//  Authentication
//
//  Created by Mac on 28/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class CreateBatchViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func tapRecognized() {
        view.endEditing(true)
    }
    
    @objc func keyboardShow() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 600, right: 0)
        print("Keyboard shown")
    }
    
    @objc func keyboardHide() {
           print("Keyboard hidden")
        scrollView.contentInset = UIEdgeInsets.zero
    }
}
