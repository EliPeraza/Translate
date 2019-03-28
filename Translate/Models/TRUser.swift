//
//  TRUser.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct TRUser {
    let userId: String
    let email: String
    let photoURL: String?
    let joinedDate: String
    
    init(userId: String, email: String, photoURL: String?, joinedDate: String) {
      self.userId = userId
      self.email = email
      self.photoURL = photoURL
      self.joinedDate = joinedDate
    }
    
    init(dict: [String: Any]) {
      self.userId = dict[TRUserCollectionKeys.UserIdKey] as? String ?? ""
      self.email = dict[TRUserCollectionKeys.EmailKey] as? String ?? ""
      self.photoURL = dict[TRUserCollectionKeys.PhotoURLKey] as? String ?? ""
      self.joinedDate = dict[TRUserCollectionKeys.JoinedDateKey] as? String ?? ""
    }
}

