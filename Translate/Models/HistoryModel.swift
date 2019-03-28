//
//  HistoryModel.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
// firebase 
struct History {
   
    let documentId: String
    let createdDate: String
  //  let imageURL: String
    let userId: String
    
    // mostly used for posting for firebase
    init(documentId: String, createdDate: String, userId: String) {
        
        self.documentId = documentId
        self.createdDate = createdDate
      //  self.imageURL = imageURL
        self.userId = userId
    }
    
    // used to read a snapshot from firebase - snapshot.data() is a dictionary
    init(dict: [String: Any]) {
        self.documentId = dict[HistoryCollectionKeys.DocumentIdKey] as? String ?? ""
        self.createdDate = dict[HistoryCollectionKeys.CreatedDateKey] as? String ?? ""
        self.userId = dict[HistoryCollectionKeys.UserIdKey] as? String ?? ""
    }
}
