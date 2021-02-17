//
//  RegistrationViewController.swift
//  Authentication
//
//  Created by Mac on 20/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var branchTF: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var docRef: DocumentReference!
    var studentCount: Int = 0
    var studentArrayCount: String = ""
    var facultyCount: Int = 0
    var facultyArrayCount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docRef = Firestore.firestore().document("sampleData/CreateUser")
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        registerationSelectionForSegment()
    }
    
    @IBAction func createUserButton(_ sender: UIButton) {
        validateUserFields()
    }
    
    //Function to set the segmented control to index 0 or 1
       func registerationSelectionForSegment() {
        let type = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!
       }
    
    //To create new student user
    func createUser_Student() {
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    print("The email address is already in use by another account.")
                    self.showAlert(title: "Sorry", message: "The email address is already in use by another account.")
                case .invalidEmail:
                    print("The email address is badly formatted.")
                    self.showAlert(title: "Sorry", message: "The email address is badly formatted.Please enter valid email")
                case .weakPassword:
                  print("The password must be 6 characters long or more.")
                     self.showAlert(title: "Sorry", message: "The password must be 6 characters long or more.")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            }else {
                //Firestore data storing
            guard let emailField = self.emailTF.text,!emailField.isEmpty else { return }
            guard let passwordField = self.passwordTF.text,!passwordField.isEmpty else { return }
            guard let nameField = self.nameTF.text,!nameField.isEmpty else { return }
            guard let branchField = self.branchTF.text,!branchField.isEmpty else { return }
            let userType = "Student"
            self.studentCount = self.studentCount + 1
            self.studentArrayCount = String(self.studentCount)
            let dataToSave: [String: Any] = ["uid":authResult?.user.uid,"email":emailField,"password": passwordField,"name": nameField,"branch": branchField,"userType": userType, "studentArrayCount": self.studentArrayCount]
            self.docRef.collection("createUser_StudentData").addDocument(data: dataToSave){ (error) in
                if let error = error {
                    print("Error", error.localizedDescription)
                }else {
                    UserDefaults.standard.set(true, forKey: "userTypeStudent")
                    print("Data has been saved")
                    print(" Student user signs up successfully")
                    
                   
                    //To naviate to next screen
                    var rootvc : UIViewController?
                    rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    let window = UIApplication.shared.windows.first
                    window?.rootViewController = rootvc
                    window?.makeKeyAndVisible()
                    self.showAlert(title: "Success", message: "Student user signs up successfully")
                    }
                }
            }
        }//else end
   }//creatUser_Student function end
    

     //To create new faculty user
     func createUser_Faculty() {
         Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { authResult, error in
             if let error = error as NSError? {
                 switch AuthErrorCode(rawValue: error.code) {
                 case .emailAlreadyInUse:
                     print("The email address is already in use by another account.")
                     self.showAlert(title: "Sorry", message: "The email address is already in use by another account.")
                 case .invalidEmail:
                     print("The email address is badly formatted.")
                     self.showAlert(title: "Sorry", message: "The email address is badly formatted.Please enter valid email")
                // case .weakPassword:
                  // print("The password must be 6 characters long or more.")
                    //  self.showAlert(title: "Sorry", message: "The password must be 6 characters long or more.")
                 default:
                     print("Error: \(error.localizedDescription)")
                 }
             }else {
                 //Firestore data storing
             guard let emailField = self.emailTF.text,!emailField.isEmpty else { return }
             guard let passwordField = self.passwordTF.text,!passwordField.isEmpty else { return }
             guard let nameField = self.nameTF.text,!nameField.isEmpty else { return }
             guard let branchField = self.branchTF.text,!branchField.isEmpty else { return }
             let userType = "Faculty"
             self.facultyCount = self.facultyCount + 1
             self.facultyArrayCount = String(self.facultyCount)
             let dataToSave: [String: Any] = ["uid":authResult?.user.uid,"email":emailField,"password": passwordField,"name": nameField,"branch": branchField,"userType": userType, "facultyArrayCount": self.facultyArrayCount]
             self.docRef.collection("createUser_FacultyData").addDocument(data: dataToSave){ (error) in
                 if let error = error {
                     print("Error", error.localizedDescription)
                 }else {
                     UserDefaults.standard.set(false, forKey: "userTypeStudent")
                     print("Data has been saved")
                     print("Faculty user signs up successfully")
                     self.showAlert(title: "Success", message: "Faculty user signs up successfully")
                     
                    //To naviate to next screen
                     var rootvc : UIViewController?
                     rootvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                     let window = UIApplication.shared.windows.first
                     window?.rootViewController = rootvc
                     window?.makeKeyAndVisible()
                     }
                 }
             }
         }//else end
    }//creatUser_Faculty function end
    
    func validateUserFields() {
        var isValid = true
            if (emailTF.text?.isEmpty)!{
                //print("plese enter text")
                showAlert(title: "Alert", message: "Please enter email")
                isValid = false
            }else {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            }
            if (passwordTF.text?.isEmpty)!{
                //print("plese enter text")
                showAlert(title: "Alert", message: "Please enter password")
                isValid = false
            }else {
                let minPasswordLength = 6
                let passwordLength = passwordTF.text!.count
                if passwordLength >= minPasswordLength {
                }
            }
            if (nameTF.text?.isEmpty)!{
            //print("plese enter text")
            showAlert(title: "Alert", message: "Please enter your name")
            isValid = false
            }
            if (branchTF.text?.isEmpty)!{
               //print("plese enter text")
               showAlert(title: "Alert", message: "Please enter either of your branch : Kothrud or Viman Nagar)")
               isValid = false
            }
            if(isValid) {
                switch segmentedControl.selectedSegmentIndex
                {
                    case 0:
                        fetchListFaculty()
                        createUser_Faculty()
                    case 1:
                        fetchListStudent()
                        createUser_Student()
                    
                    default:
                    break
                }
             }
        }
    
    //To fetch the snapshot and get the latest count for faculty user
    func fetchListFaculty() {
             let docRef = Firestore.firestore().document("sampleData/CreateUser")
              docRef.collection("createUser_FacultyData").getDocuments{ (docSnapshot, error) in
                   if error == nil {
                      let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                      for data in myData {
                          let myFacultyEmail = data["email"] as! String
                          self.facultyArrayCount = data["facultyArrayCount"] as! String
                          self.facultyCount = Int(self.facultyArrayCount)!
                          print(self.facultyCount)
                      }
                   }
              }
      }//end fetchList()
    
     //To fetch the snapshot and get the latest count for student user
    func fetchListStudent() {
             let docRef = Firestore.firestore().document("sampleData/CreateUser")
              docRef.collection("createUser_StudentData").getDocuments{ (docSnapshot, error) in
                   if error == nil {
                      let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                      for data in myData {
                          let myStudentEmail = data["email"] as! String
                          self.studentArrayCount = data["studentArrayCount"] as! String
                          self.studentCount = Int(self.studentArrayCount)!
                          print(self.studentCount)
                      }
                   }
              }
      }//end fetchList()
      
    //General method used to show alert
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}//Class ends
