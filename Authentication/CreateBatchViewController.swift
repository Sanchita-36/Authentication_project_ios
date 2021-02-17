//
//  CreateBatchViewController.swift
//  Authentication
//
//  Created by Mac on 28/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CreateBatchViewController: UIViewController {
    
    @IBOutlet weak var batchTypeTF: UITextField!
    @IBOutlet weak var batchNameTF: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var fromTime: UITextField!
    @IBOutlet weak var toTime: UITextField!
    @IBOutlet weak var branchNameTF: UITextField!
    @IBOutlet weak var facultyNameTF: UITextField!
    //@IBOutlet weak var studentEmailTF: UITextField!
    @IBOutlet weak var studentCountTF: UITextField!
    
    var tapGesture: UITapGestureRecognizer!
    var docRef: DocumentReference!
    
    let timepicker = UIDatePicker()
    let datepicker = UIDatePicker()
    var data: [Int: [Any]] = [:]
    var studentAttendance: [String: Bool] = [:]
    var toDateString: String = ""
    var toTimeString: String = ""
    var studentCount: Int = 0
    var studentEmail: [String] = []
    var studentEmailArray: [String] = []
    var systemDate: String = ""
    var batchStatus: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        docRef = Firestore.firestore().document("sampleData/CreateBatch")
          
        studentCountTF.text = String(self.studentCount)
        print(studentCountTF.text as Any)
        self.studentEmailArray = studentEmail
        print(self.studentEmailArray)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //timePicker view for startTime
        let startTimetoolbar = UIToolbar()
        startTimetoolbar.sizeToFit()
        let startTimeDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                             action: #selector(fromTimeDoneButtonClicked))
        startTimetoolbar.items = [startTimeDoneBtn]
        fromTime.inputAccessoryView = startTimetoolbar
        fromTime.inputView = timepicker
        timepicker.datePickerMode = .time
               
        //timePicker view for endTime
        let endTimetoolbar = UIToolbar()
        endTimetoolbar.sizeToFit()
        let endTimeDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                             action: #selector(toTimeDoneButtonClicked))
        endTimetoolbar.items = [endTimeDoneBtn]
        toTime.inputAccessoryView = endTimetoolbar
        toTime.inputView = timepicker
        timepicker.datePickerMode = .time
        
        //datePicker view for startTime
        let fromDateToolBar = UIToolbar()
        fromDateToolBar.sizeToFit()
        let fromDateDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                      action: #selector(tapFromDateDone))
        fromDateToolBar.items = [fromDateDoneBtn]
        fromDate.inputAccessoryView = fromDateToolBar
        fromDate.inputView = datepicker
        datepicker.datePickerMode = .date
        
        //datePicker view for endTime
         let toDateToolBar = UIToolbar()
         toDateToolBar.sizeToFit()
         let toDateDoneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                            action: #selector(tapToDateDone))
         toDateToolBar.items = [toDateDoneBtn]
         toDate.inputAccessoryView = toDateToolBar
         toDate.inputView = datepicker
         datepicker.datePickerMode = .date
    }

    //done button clicked for startTime picker view
    @objc func fromTimeDoneButtonClicked(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeStyle = .short
        fromTime.text = formatter.string(from: timepicker.date)
        let date = timepicker.date
        self.view.endEditing(true)
    }
       
    //done button clicked for endTime picker view
    @objc func toTimeDoneButtonClicked(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeStyle = .short
        toTime.text = formatter.string(from: timepicker.date)
        let date = timepicker.date
        self.view.endEditing(true)
    }
    
    //done button for fromDate date picker
     @objc func tapFromDateDone() {
         if let datePicker = self.fromDate.inputView as? UIDatePicker {
         let dateformatter = DateFormatter()
         dateformatter.dateStyle = .medium
         self.fromDate.text = dateformatter.string(from: datePicker.date)
        }
    self.fromDate.resignFirstResponder()
  }
    
   //done button for toDate date picker
    @objc func tapToDateDone() {
        if let datePicker = self.toDate.inputView as? UIDatePicker {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        self.toDate.text = dateformatter.string(from: datePicker.date)
       }
    self.toDate.resignFirstResponder()
  }
    
    func valiDate() -> Bool {
        var isValid = true
            if ((batchTypeTF.text?.isEmpty) == true){
                showAlert(title: "Alert", message: "Enter your batch type")
                isValid = false
                }
        
            if ((batchNameTF.text?.isEmpty) == true){
                 showAlert(title: "Alert", message: "Enter your branch name")
                 isValid = false
                }
        
            if ((fromDate.text?.isEmpty) == true) || ((toDate.text?.isEmpty) == true){
                   showAlert(title: "Alert", message: "Select date")
                   isValid = false
                 }
           
            if ((fromTime.text?.isEmpty) == true) || ((toTime.text?.isEmpty) == true){
                   showAlert(title: "Alert", message: "Select Time")
                   isValid = false
                 }
        
            if ((branchNameTF.text?.isEmpty) == true){
                 showAlert(title: "Alert", message: "Enter your batch name")
                 isValid = false
                }
        
            if ((facultyNameTF.text?.isEmpty) == true){
                 showAlert(title: "Alert", message: "Enter your name")
                 isValid = false
                }
            
            if ((studentCountTF.text?.isEmpty) == true){
             showAlert(title: "Alert", message: "Please select stduents from 'Add Students button' ")
             isValid = false
            }
        
               /* isValid = false
                studentAttendance.values.forEach({ (a) in
                    if (a){
                        isValid = true
                    }
                })*/
        return true
    }
    
    @objc func tapRecognized() {
        view.endEditing(true)
    }
    
    @objc func keyboardShow() {
       // scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        print("Keyboard shown")
    }
    
    @objc func keyboardHide() {
        print("Keyboard hidden")
       // scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func addStudentButton(_ sender: UIButton) {
          let vc = storyboard?.instantiateViewController(identifier: "StudentCountCollectionViewController") as! StudentCountCollectionViewController
              navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func createButtonClicked(_ sender: UIButton) {
        let boolean = valiDate()
        if boolean == true {
            
            //Firestore data storing
            guard let batchTypeField = self.batchTypeTF.text,!batchTypeField.isEmpty else { return }
            guard let batchNameField = self.batchNameTF.text,!batchNameField.isEmpty else { return }
            guard let fromDateField = self.fromDate.text,!fromDateField.isEmpty else { return }
            guard let toDateField = self.toDate.text,!toDateField.isEmpty else { return }
            guard let fromTimeField = self.fromTime.text,!fromTimeField.isEmpty else { return }
            guard let toTimeField = self.toTime.text,!toTimeField.isEmpty else { return }
            guard let branchNameField = self.branchNameTF.text,!branchNameField.isEmpty else { return }
            guard let facultyNameField = self.facultyNameTF.text,!facultyNameField.isEmpty else { return }
            guard let studentCountTextField = self.studentCountTF.text, !studentCountTextField.isEmpty else {return}
            
            let uid = Auth.auth().currentUser?.uid
            
            self.toDateString = "\(fromDateField)" + " - " + "\(toDateField)"
            self.toTimeString = "\(fromTimeField)" + " - " + "\(toTimeField)"
            print(self.toDateString)
            print(self.toTimeString)
            
            let datePickerToSave = UIDatePicker()
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            self.systemDate = formatter.string(from: datePickerToSave.date)
            print(systemDate)
            
            if self.systemDate < toDateField {
                self.batchStatus = "Ongoing"
            }else if self.systemDate > toDateField{
                self.batchStatus = "Completed"
            }
            
            let batchID = docRef.collection("batch").document().documentID
            
            let dataToSave: [String: Any] = ["batchID":batchID, "batchType":batchTypeField, "batchName": batchNameField, "toDate":toDateField, "fromDate":fromDateField, "toTime":toTimeField, "fromTime":fromTimeField, "branchName":branchNameField, "facultyName":facultyNameField, "studentCount": self.studentCount, "studentEmail":self.studentEmailArray, "DateString": self.toDateString, "TimeString": self.toTimeString, "batchStatus": self.batchStatus,"facultyID": uid!]
            self.docRef.collection("batch").addDocument(data: dataToSave){ (error) in
                if let error = error {
                    print("Error", error.localizedDescription)
                }else {
                    print("Data has been saved")
                }
            }
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


