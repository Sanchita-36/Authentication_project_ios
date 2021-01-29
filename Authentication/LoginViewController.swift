//
//  ViewController.swift
//  Authentication
//
//  Created by Mac on 28/12/20.
//  Copyright © 2020 Sanchita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logo_felix: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentSelected: UISegmentedControl!
    
    var tapGesture: UITapGestureRecognizer!
    var ref: DatabaseReference!
    var docRef: DocumentReference!
    var register: RegistrationViewController!
    var myFacultyEmail: String = ""
    var myStudentEmail :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if segmentSelected.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(false, forKey: "userTypeStudent")
            fetchListFaculty()
        }
        
        
        
        //rounding only bottom corners of a logo
        logo_felix.layer.cornerRadius = 30.0
        logo_felix.clipsToBounds = true
        logo_felix.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        //to add bottom line for entering email
        let emailBottomLine = CALayer()                           // object creation of class CALayer
        emailBottomLine.frame = CGRect(x: 0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1)
        emailBottomLine.backgroundColor = UIColor.black.cgColor
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(emailBottomLine)
        
        //to add bottom line for entering email
        let passwordBottomLine = CALayer()
        passwordBottomLine.frame = CGRect(x: 0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1)
        passwordBottomLine.backgroundColor = UIColor.black.cgColor
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(passwordBottomLine)
        
        // Tap Gesture
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
        tapGesture.isEnabled = false
        self.scrollView.isScrollEnabled = false
        view.addGestureRecognizer(tapGesture)
                
        //Fetch keyboard notification(this is a brodcaster)
        NotificationCenter.default.addObserver(self, selector: #selector(didShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        //Firebase authentication [we add below code to get the realtime database link in ref variable]
          ref = Database.database().reference()
        
        //Firestore reference. Document creation
          docRef = Firestore.firestore().document("sampleData/Users")
        
    }
    
    //To select segment on clicking on the segmented control view.
    @IBAction func indexChangedForSegment(_ sender: UISegmentedControl) {
        loginSelectionForSegment()
       }
    
    @objc func tapRecognized() {
        self.view.endEditing(true)
    }
            
    @objc func didShow(notification: Notification) {
        tapGesture.isEnabled = true
        self.scrollView.isScrollEnabled = true
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            {
                let keyboardHeight = frame.cgRectValue.height
                self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
                self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            }
        print("Keyboard did show")
    }
      
    @objc func didHide (notification: Notification) {
        tapGesture.isEnabled = false
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        self.scrollView.isScrollEnabled = false
        print("Keyboard did hide")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        valiDate()
    } // end button login func
    
    var rootVC : UIViewController?
    @IBAction func signUpTapped(_ sender: Any) {
    rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        let window = UIApplication.shared.windows.first
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
    
    func loginForFaculty(){
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Please enter valid creds", message: "Check email and password", preferredStyle: .alert)
                    self.present(alert, animated: true)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                    print("Error",error?.localizedDescription as Any)
                }else {
                    print("User signs in successfully")
                    
                    //Firestore data storing
                        guard let emailField = self.emailTextField.text,!emailField.isEmpty else { return }
                        guard let passwordField = self.passwordTextField.text,!passwordField.isEmpty else { return }
                    let dataToSave: [String: Any] = ["uid":result?.user.uid,"email":emailField,"password": passwordField]
                        self.docRef.collection("loginDataFaculty").addDocument(data: dataToSave){ (error) in
                            if let error = error {
                                print("Error", error.localizedDescription)
                            }else{
                                print("Data has been saved")
                            }
                        }
                   //code added to show the screens as per users login logout status
                    UserDefaults.standard.set(true, forKey: "status") //To store data
                    Switcher.updateRootVC()
                } //end else
            } // end auth method
    }

    func loginForStudent(){
           Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                   if error != nil {
                       let alert = UIAlertController(title: "Please enter valid creds", message: "Check email and password", preferredStyle: .alert)
                       self.present(alert, animated: true)
                       alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                       print("Error",error?.localizedDescription as Any)
                   }else {
                       print("User signs in successfully")
                       
                       //Firestore data storing
                           guard let emailField = self.emailTextField.text,!emailField.isEmpty else { return }
                           guard let passwordField = self.passwordTextField.text,!passwordField.isEmpty else { return }
                           let dataToSave: [String: Any] = ["email":emailField,"password": passwordField]
                           self.docRef.collection("loginDataStudent").addDocument(data: dataToSave){ (error) in
                               if let error = error {
                                   print("Error", error.localizedDescription)
                               }else {
                                   print("Data has been saved")
                               }
                           }
                      //code added to show the screens as per users login logout status
                       UserDefaults.standard.set(true, forKey: "status") //To store data
                       Switcher.updateRootVC()
                   } //end else
               } // end auth method
       }
    
    //To fetech data from firestore and show it in side table view
      func fetchListFaculty() {
           let docRef = Firestore.firestore().document("sampleData/CreateUser")
            docRef.collection("createUser_FacultyData").getDocuments{ (docSnapshot, error) in
                 if error == nil {
                    let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                    for data in myData {
                        self.myFacultyEmail = data["email"] as! String
                        print(self.myFacultyEmail)
                    }
                 }
            }
    }//end fetchList()
    
    
    func fetchListStudent() {
        let docRef = Firestore.firestore().document("sampleData/CreateUser")
                docRef.collection("createUser_StudentData").getDocuments{ (docSnapshot, error) in
                     if error == nil {
                        let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                        for data in myData {
                            self.myStudentEmail = data["email"] as! String
                            print(self.myStudentEmail)
                        }
                     }
                }
    }
    
    
    //Function to set the segmented control to index 0 or 1
    func loginSelectionForSegment() {
        let type = self.segmentSelected.titleForSegment(at: self.segmentSelected.selectedSegmentIndex)
        
        if segmentSelected.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(false, forKey: "userTypeStudent")
            fetchListFaculty()
        }
        
        if segmentSelected.selectedSegmentIndex == 1{
            UserDefaults.standard.set(true, forKey: "userTypeStudent")
            fetchListStudent()
        }
    }
    
    // validation code on loging screen
    func valiDate() {
        var isValid = true
        if (emailTextField.text?.isEmpty)!{
            //print("plese enter text")
            showAlert(title: "Aleart", message: "Email is invalid")
            isValid = false
        }
        if (passwordTextField.text?.isEmpty)!{
            //print("plese enter text")
            showAlert(title: "Aleart", message: "Password is invalid")
            isValid = false
        }
        if (isValid) {
            switch segmentSelected.selectedSegmentIndex
            {
            case 0:
                if((UserDefaults.standard.bool(forKey: "userTypeStudent") == false) && myFacultyEmail != emailTextField.text){
                    print("Not a faculty. Please enter valid faculty email")
                    showAlert(title: "Oops!", message: "Not a faculty. Please enter valid faculty email")
                }else {
                    loginForFaculty()
                }
                
            case 1:
                if((UserDefaults.standard.bool(forKey: "userTypeStudent") == true) && myStudentEmail != emailTextField.text){
                    print("Not a Student. Please enter valid student email")
                    showAlert(title: "Oops!", message: "Not a Student. Please enter valid student email")
                }else {
                    loginForStudent()
                }
               // DataHolder.isStudentView = true
            default:
                break
            }
        }
        
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
} // end class



