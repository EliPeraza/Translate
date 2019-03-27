//
//  DBService_TranslatedQuery.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct HistoryCollectionKeys {
    static let CollectionKey = "histories"
    static let UserIdKey = "userId"
    static let CreatedDateKey = "createdDate"
    static let DocumentIdKey = "documentId"
//    static let ImageURLKey = "imageURL"
}

extension DBService {
    // writing to firebase:
    // 1. we need a reference to the database - DBService.firestoreDB
    // 2. what collection are you writing to? e.g "dishes" (DishesCollectionKeys.CollectionKey)
    // 3. write to the collection e.g setData, updateData, delete
    // create new document - use setData
    // update existing document - use updateData
    
    static public func historyData(history: History, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(HistoryCollectionKeys.CollectionKey)
            .document(history.documentId).setData([
                HistoryCollectionKeys.CreatedDateKey     : history.createdDate,
                HistoryCollectionKeys.UserIdKey          : history.userId,
               // DishesCollectionKeys.ImageURLKey        : dish.imageURL,
                HistoryCollectionKeys.DocumentIdKey      : history.documentId
                ])
            { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
    static public func deleteHistory(history: History, completion: @escaping (Error?) -> Void) { // for the delete part
        // steps for deleting
        // step 1: we need the database reference (DBService.firestoreDB)
        // step 2: get the collection we're interested in
        // step 3: pass in the dish's document id you want to delete
        DBService.firestoreDB
            .collection(HistoryCollectionKeys.CollectionKey)
            .document(history.documentId)
            .delete { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
    
    static public func enterTranslate(history: History) {
        firestoreDB.collection(HistoryCollectionKeys.CollectionKey)
            .document(history.documentId).setData([
                HistoryCollectionKeys.CreatedDateKey     : history.createdDate,
                HistoryCollectionKeys.UserIdKey       : history.userId,
                //                HistoryCollectionKeys.ImageURLKey        : history.imageURL,
                HistoryCollectionKeys.DocumentIdKey      : history.documentId
                ])
            { (error) in
                if let error = error {
                    print("posting blog error: \(error)")
                } else {
                    print("blog posted successfully to ref: \(history.documentId)")
                }
        }
    }

//    static public func fetchTranslateCreator(userID: String, completion: @escaping (Error?, User?) -> Void) {
//        DBService.firestoreDB
//            .collection(UserCollectionKeys.CollectionKey)
//            .whereField(UserCollectionKeys.UserIdKey, isEqualTo: userID)
//            .getDocuments { (snapshot, error) in
//                if let error = error {
//                    completion(error, nil)
//                } else if let snapshot = snapshot?.documents.first {
//                    // let translateCreator = User(dict: snapshot.data())
//                   // completion(nil, translateCreator)
//                }
//        }
//    }
    
//    static public func fetchDishCreator(userId: String, completion: @escaping (Error?, NDUser?) -> Void) {
//        DBService.firestoreDB
//            .collection(NDUsersCollectionKeys.CollectionKey)
//            .whereField(NDUsersCollectionKeys.UserIdKey, isEqualTo: userId)
//            .getDocuments { (snapshot, error) in
//                if let error = error {
//                    completion(error, nil)
//                } else if let snapshot = snapshot?.documents.first {
//                    let dishCreator = NDUser(dict: snapshot.data())
//                    completion(nil, dishCreator)
//                }
//        }
//    }
}
