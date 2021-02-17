//
//  BatchViewController.swift
//  Authentication
//
//  Created by Mac on 08/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class BatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //delegate for the pass data to privious vies controller
    var batchDelegate: BatchDelegate?

    @IBOutlet weak var batchTableView: UITableView!
    
    var data: [Batch] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return data.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "batchCell") as! BatchTableViewCell
            cell.batchNameLB.text = data[indexPath.row].batchName
            cell.batchDateLB.text = data[indexPath.row].DateString
            cell.batchFromTimeLB.text = data[indexPath.row].fromTime
            cell.batchToTimeLB.text = data[indexPath.row].toTime
            cell.batchAttendanceLB.text = String(data[indexPath.row].studentCount) + " Students"
            let batch = data[indexPath.row]
        if DataHolder.currentBatch.batchType == batch.batchType {
                    cell.accessoryType = .checkmark
                }else {
                    cell.accessoryType = .none
                }
            return cell
       }
    
    // selction the batch form the alloted list
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let batch = data[indexPath.row]
        DataHolder.currentBatch = batch
        
        tableView.deselectRow(at: indexPath, animated: false)
                     if let cell = tableView.cellForRow(at: indexPath) {
                         if cell.accessoryType == .checkmark {
                             cell.accessoryType = .none
                         } else {
                             cell.accessoryType = .checkmark
                         }
                     }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = DataHolder.currentBatches
        self.navigationItem.title = "BATCHES"
        tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmis))
    }

    @objc func dissmis(){
        batchDelegate?.refreshTopics()
        self.dismiss(animated: true)
        
    }

}
