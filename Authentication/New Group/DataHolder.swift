//
//  DataHolder.swift
//  Authentication
//
//  Created by Mac on 08/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation

class DataHolder {
    
    static var currentBatch: Batch = Batch()
    static var currentBatches: [Batch] = []
   // static var currentAttendance = Attendance()
   // static var currentBatchAttendance:[Attendance] = []
  //  static var currentBatchStudents : [User] = []
    static var isStudentView = false
    static var currentUser:User = User()
    static var currentUserId = ""
    
}
