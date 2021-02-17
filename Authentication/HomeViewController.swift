//
//  TableViewController.swift
//  Authentication
//
//  Created by Mac on 04/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController, BatchDelegate {
    func refreshTopics(){
        updateViewLabels()
    }
    
    @IBOutlet weak var todoTableView: UITableView!
   
    @IBOutlet weak var showLoggedInLabel: UILabel!
    @IBOutlet weak var showCreateButton: UIButton!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var numberLB: UILabel!
    
    
    var todoArray: [String] = []
    var showLabel: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.bool(forKey: "userTypeStudent") == true)
            {
                showLoggedInLabel.text = "Student Login"
                showCreateButton.isHidden = true
            }else {
                showLoggedInLabel.text = "Faculty Login"
            showCreateButton.isHidden = false
            }
       
        fetchList()
        fetchBatch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = false
    }

    //To navigate to batches screen once clicked on change button
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        //To naviate to next screen - Batches
        let todoVC = self.storyboard?.instantiateViewController(identifier: "BatchViewController") as! BatchViewController
        let nav = UINavigationController(rootViewController: todoVC)
        todoVC.batchDelegate = self
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func createBatchButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "CreateBatchViewController") as! CreateBatchViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //To fetech data from firestore and show it in side table view
    func fetchList() {
         let docRef = Firestore.firestore().document("sampleData/Users")
          docRef.collection("loginDataFaculty").getDocuments{ (docSnapshot, error) in
               if error == nil {
                  let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                  for data in myData {
                      let myEmail = data["email"] as! String
                      self.todoArray.append(myEmail)
                      }
                  self.todoTableView.reloadData()
                  }
               }
          } //end fetchList()
    
    func fetchBatch(){
        fetchFacultyBatchAndTopics()
        updateViewLabels()
    }
    
    //update labels on view
       func updateViewLabels() {
           let batch = DataHolder.currentBatch
           let batchType = batch.batchName + " - " +  batch.batchType
           nameLB.text = batchType
           let batchTiming = batch.TimeString
           timeLB.text = batchTiming
           let studentsCount = String(batch.studentCount) + " Students"
           numberLB.text = studentsCount
       }
    
    // in this function fetch batch for student and faculty
    /*  func fetchBatch(){
        let docRef = Firestore.firestore().document("sampleData/CreateBatch")
                 docRef.collection("batch").getDocuments{ (docSnapshot, error) in
                      if error == nil {
                         let myData = docSnapshot!.documents as [QueryDocumentSnapshot]
                         for data in myData {
                             let dataID = data.documentID
                             let batchID = data["batchID"] as! String
                             let batchName = data["batchName"] as! String
                             print(batchName)
                            print(batchID)
                            print(dataID)
                             }
                         }
     }*/

    
    //this func for fetch batch and topics for faculty
     func fetchFacultyBatchAndTopics(){
         let uid = Auth.auth().currentUser?.uid
        let batchRef = DatabaseReferenceManager.shared.getBatchesReference().whereField("facultyID", isEqualTo: uid!).whereField("batchStatus", isEqualTo: "Ongoing")
         batchRef.addSnapshotListener(includeMetadataChanges: false) { (documents, error) in
             if (!(documents?.isEmpty)!){
                 var currentBatchesArray: [Batch] = []
                
                if (error != nil) {
                     print("something is wrong")
                 }else {
                     // btn_change_batch.visibility = View.VISIBL
                     documents?.documents.forEach({ (doc) in
                         let data = doc.data()
                         let cBatch = Batch(data: data)
                         currentBatchesArray.append(cBatch)
                     })
                     DataHolder.currentBatches = currentBatchesArray
                     self.todoTableView.reloadData()
                 }
             } else{
                 print("Error retreiving collection: \(String(describing: error?.localizedDescription))")
             }
         }
     }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "homeViewCell")
          cell?.textLabel?.text = todoArray[indexPath.row]
          return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    }
 }
