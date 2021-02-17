//
//  Batch.swift
//  Authentication
//
//  Created by Mac on 08/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

class Batch {
  var batchID:String = ""
  var batchType: String = ""
  var batchName: String = ""
  var toDate: String = ""
  var fromDate: String = ""
  var toTime: String = ""
  var fromTime:String = ""
  var branchName: String = ""
  var facultyName: String = ""
  var studentCount: Int = 0
  var studentEmail: [String] = []
  var DateString: String = ""
  var TimeString: String = ""
    
  init(){
           
        }
       
  init(data: [String: Any]) {
           self.batchID = data["batchID"] as? String ?? ""
           self.batchType = data["batchType"] as? String ?? ""
           self.batchName = data["batchName"] as? String ?? ""
           self.toDate = data["toDate"] as? String ?? ""
           self.fromDate = data["fromDate"] as? String ?? ""
           self.toTime = data["toTime"] as? String ?? ""
           self.fromTime = data ["fromTime"] as? String ?? ""
           self.branchName = data["branchName"] as? String ?? ""
           self.facultyName = data["facultyName"] as? String ?? ""
           self.studentCount = data["studentCount"] as? Int ?? 0
           self.studentEmail = data["studentEmail"] as? Array ?? []
           self.DateString = data["DateString"] as? String ?? ""
           self.TimeString = data["TimeString"] as? String ?? ""
    }

}
