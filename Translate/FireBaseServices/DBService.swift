//
//  DBService.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

//struct UserCollectionKeys {
//    static let CollectionKey = "bloggers"
//    static let UserIdKey = "bloggerId"
//    static let EmailKey = "email"
//    static let PhotoURLKey = "photoURL"
//    static let JoinedDateKey = "joinedDate"
//}


final class DBService {
    private init() {}
    
    public static var firestoreDB: Firestore = {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        return db
    }()
    
//    static public var generateDocumentId: String {
//        return firestoreDB.collection(UserCollectionKeys.CollectionKey).document().documentID
//    }
    
//    static public func createBlogger(user: User, completion: @escaping (Error?) -> Void) {
//        firestoreDB.collection(UserCollectionKeys.CollectionKey)
//            .document(user.userId)
//            .setData([ HistoryCollectionKeys.UserIdKey : user.bloggerId,
//                       UserCollectionKeys.EmailKey       : user.email,
//                       UserCollectionKeys.JoinedDateKey  : user.joinedDate
//
//            ]) { (error) in
//                if let error = error {
//                    completion(error)
//                } else {
//                    completion(nil)
//                }
//        }
//    }
    
//    static public func fetchUser(userId: String, completion: @escaping (Error?, User?) -> Void) {
//        DBService.firestoreDB
//            .collection(UserCollectionKeys.CollectionKey)
//            .whereField(UserCollectionKeys.UserIdKey, isEqualTo: userId)
//            .getDocuments { (snapshot, error) in
//                if let error = error {
//                    completion(error, nil)
//                } else if let snapshot = snapshot?.documents.first {
//                    let translating = User(dict: snapshot.data())
//                    completion(nil, translating)
//                }
//        }
//    }
    
//    static public func editUpdateBlog(history: History){
//        firestoreDB.collection(HistoryCollectionKeys.CollectionKey).document(blog.documentId).updateData([
//            HistoryCollectionKeys.CreatedDateKey     : history.createdDate,
//            HistoryCollectionKeys.BlogDescritionKey  : history.blogDescription,
//            ]) { (error) in
//                if let error = error {
//                    print("editing blog error: \(error)")
//                } else {
//                    print("blog edit successfully to ref: \(history.documentId)")
//                }
//        }
//    }
    
//    static public func editProfileUpdateBlog(user: User){
//        firestoreDB.collection(UserCollectionKeys.CollectionKey)
//            .document(blogger.bloggerId)
//            .setData([ UserCollectionKeys.BloggerIdKey : user.bloggerId,
//                       UserCollectionKeys.EmailKey       : user.email,
//                       UserCollectionKeys.JoinedDateKey  : user.joinedDate
//            ]) { (error) in
//                if let error = error {
//                    print("editing blog error: \(error)")
//                } else {
//                    print("blog edit successfully to ref: \(user.userId)")
//                }
//        }
//    }
    
//    static public func deleteFavorite(history: History
//        , completion: @escaping (Error?) -> Void) {
//        DBService.firestoreDB
//            .collection(HistoryCollectionKeys.CollectionKey)
//            .document(History.documentId)
//            .delete { (error) in
//                if let error = error {
//                    completion(error)
//                } else {
//                    completion(nil)
//                }
//        }
//    }
//    
//    static public func fetchTranslateCreator(userID: String, completion: @escaping (Error?, User?) -> Void) {
//        DBService.firestoreDB
//            .collection(UserCollectionKeys.CollectionKey)
//            .whereField(UserCollectionKeys.UserIdKey, isEqualTo: userID)
//            .getDocuments { (snapshot, error) in
//                if let error = error {
//                    completion(error, nil)
//                } else if let snapshot = snapshot?.documents.first {
//                   // let translateCreator = User(dict: snapshot.data())
//                    completion(nil, translateCreator)
//                }
//        }
//    }
    
//    static public func fetchAllBloggers(completion: @escaping(Error?, [Blogger]?) -> Void) {
//        let query = firestoreDB.collection(UserCollectionKeys.CollectionKey)
//        query.getDocuments { (snapshot, error) in
//            if let error = error {
//                completion(error, nil)
//            }
//            if let snapshot = snapshot {
//                var bloggers = [Blogger]()
//                for document in snapshot.documents {
//                    let allBlogger = Blogger.init(dict: document.data())
//                    bloggers.append(allBlogger)
//                }
//                completion(nil, bloggers)
//            }
//        }
//    }
}
