//
//  DBService+User.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


struct TRUserCollectionKeys {
  static let CollectionKey = "users"
  static let UserIdKey = "userId"
  static let DisplayNameKey = "displayName"
  static let EmailKey = "email"
  static let PhotoURLKey = "photoURL"
  static let JoinedDateKey = "joinedDate"
}

extension DBService {
  static public func createdUser(user: TRUser, completion: @escaping (Error?) -> Void) {
    firestoreDB.collection(TRUserCollectionKeys.CollectionKey)
      .document(user.userId)
      .setData([ TRUserCollectionKeys.UserIdKey : user.userId,
                 TRUserCollectionKeys.DisplayNameKey : user.displayName,
                 TRUserCollectionKeys.EmailKey       : user.email,
                 TRUserCollectionKeys.PhotoURLKey    : user.photoURL ?? "",
                 TRUserCollectionKeys.JoinedDateKey  : user.joinedDate
      ]) { (error) in
        if let error = error {
          completion(error)
        } else {
          completion(nil)
        }
    }
  }
  
  static public func fetchUser(userId: String, completion: @escaping (Error?, TRUser?) -> Void) {
    DBService.firestoreDB
      .collection(TRUserCollectionKeys.CollectionKey)
      .whereField(TRUserCollectionKeys.UserIdKey, isEqualTo: userId)
      .getDocuments { (snapshot, error) in
        if let error = error {
          completion(error, nil)
        } else if let snapshot = snapshot?.documents.first {
          let dishCreator = TRUser(dict: snapshot.data())
          completion(nil, dishCreator)
        }
    }
  }
}
