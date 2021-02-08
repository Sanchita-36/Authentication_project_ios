//
//  SampleViewController.swift
//  Authentication
//
//  Created by Mac on 03/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class StudentCountCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var docRef: DocumentReference!
    var todoArray: [String] = []
    var counter: Int = 0
    var count: Int = 0
    var temp: [String] = []
    @IBOutlet weak var mySampleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }
    @IBAction func collectStudentData(_ sender: UIButton) {
        validateCollectStudents()
    }
    //To fetech data from firestore and show it in side table view
    func fetchStudents() {
        let docRef = Firestore.firestore().document("sampleData/CreateUser")
            docRef.collection("createUser_StudentData").getDocuments{ (docSnapshot, error) in
               if error == nil {
                  let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                  for data in myData {
                      let myEmail = data["email"] as! String
                      self.todoArray.append(myEmail)
                      }
                  self.mySampleTableView.reloadData()
                  }
               }
          } //end fetchList()
    
    func validateCollectStudents() {
        if self.counter > 0 {
        let cr: CreateBatchViewController =
            self.storyboard?.instantiateViewController(identifier: "CreateBatchViewController") as! CreateBatchViewController
        cr.studentCount = Int(self.counter)
        cr.studentEmail = self.temp
        self.navigationController?.pushViewController(cr, animated: true)
        }else {
            showAlert(title: "Alert", message: "Please select stduents")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = todoArray[indexPath.row]
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
              tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
              self.counter = self.counter - 1
              print(self.counter)
          }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
              tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
              self.counter = self.counter + 1
              cell?.textLabel?.text  = todoArray[indexPath.row]
              let sampleData = (cell?.textLabel?.text)!
              if counter >= 1 {
                while self.count < counter {
                    self.temp.insert(sampleData, at: count)
                    self.count = self.count + 1
                }
            }
            print(self.temp)
            print(self.counter)
          }
      }

      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == UITableViewCell.EditingStyle.delete{
              todoArray.remove(at: indexPath.row)
              tableView.reloadData()
          }
      }
    
    func showAlert(title: String, message: String){
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "GOT IT ", style: .cancel, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
    
}

