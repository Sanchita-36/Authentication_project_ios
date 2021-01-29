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

class HomeViewController: UIViewController {

    var todoArray: [String] = []
    var showLabel: String = ""
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var showLoggedInLabel: UILabel!
    @IBOutlet weak var showCreateButton: UIButton!
    
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
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    
    //To navigate to batches screen once clicked on change button
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        //To naviate to next screen - Batches
        let todoVC = self.storyboard?.instantiateViewController(identifier: "BatchesTableViewController") as! BatchesTableViewController
        self.navigationController?.pushViewController(todoVC, animated: true)
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

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
              cell?.textLabel?.text = todoArray[indexPath.row]
              return cell!
    }
     
 }
