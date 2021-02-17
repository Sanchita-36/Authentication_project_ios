//
//  DatabaseReferenceManager.swift
//  Authentication
//
//  Created by Mac on 08/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import Firebase

class DatabaseReferenceManager{
    
    private class ReferenceKeys {
           static var CREATEUSER = "CreateUser"
           static var FACULTYUSER = "createUser_FacultyData"
           static var STUDENTUSER = "createUser_StudentData"
           static var CREATEBATCH = "CreateBatch"
           static var BATCH = "batch"
           static var SAMPLEDATA = "sampleData"
       }
    
    private static var ENVIRONMENT = "sampleData"
    
    public static let shared = DatabaseReferenceManager()
    
    private func getDatabaseReference() -> CollectionReference {
        return Firestore.firestore().collection(ReferenceKeys.SAMPLEDATA)
    }
    
    func getStudentUserReference() -> CollectionReference {
          return getDatabaseReference().document(ReferenceKeys.CREATEUSER).collection(ReferenceKeys.STUDENTUSER)
      }
    
    func getFacultyUserReference() -> CollectionReference {
             return getDatabaseReference().document(ReferenceKeys.CREATEUSER).collection(ReferenceKeys.FACULTYUSER)
      }
    
    func getBatchesReference()-> CollectionReference {
    return getDatabaseReference().document(ReferenceKeys.CREATEBATCH).collection(ReferenceKeys.BATCH)
      }
    
}

