//
//  Batch.swift
//  Authentication
//
//  Created by Mac on 14/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

class Batch{
  var module: String = ""
  var fromDateString: String = ""
  var toTime: String = ""
  var fromTime: String = ""
  var studentsArray: [String] = [ ]
  var batchId: String = ""
    
  init(){
           
        }
       
  init(data: [String: Any]) {
           self.module = data["Angular"] as? String ?? ""
           self.fromDateString = data["20/01/2021"] as? String ?? ""
           self.toTime = data["5:00 PM"] as? String ?? ""
           self.fromTime = data["7:00 PM"] as? String ?? ""
           self.studentsArray = data["2"] as? Array ?? []
           self.batchId = data["001"] as? String ?? ""
    }

}

