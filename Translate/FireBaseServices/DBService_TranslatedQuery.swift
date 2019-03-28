//
//  DBService_TranslatedQuery.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import FirebaseAuth

struct HistoryCollectionKeys {
    static let CollectionKey = "histories"
    static let UserIdKey = "userId"
    static let CreatedDateKey = "createdDate"
    static let DocumentIdKey = "documentId"
    static let InputLanguageText = "inputLanguageText"
    static let InputText = "inputText"
    static let TransLanguagetext = "transLanguagetext"
    static let TransedText = "transedText"
    
}

extension DBService {
    static public func historyData(history: History, completion: @escaping (Error?) -> Void) {
        firestoreDB.collection(HistoryCollectionKeys.CollectionKey)
            .document(history.documentId).setData([
                HistoryCollectionKeys.CreatedDateKey     : history.createdDate,
                HistoryCollectionKeys.UserIdKey          : history.userId,
                HistoryCollectionKeys.DocumentIdKey      : history.documentId,
                HistoryCollectionKeys.InputLanguageText  : history.inputLanguageText,
                HistoryCollectionKeys.InputText          : history.inputText,
                HistoryCollectionKeys.TransLanguagetext : history.transLanguagetext,
                HistoryCollectionKeys.TransedText       : history.transedText
                
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
 
    
    static public var generateDocumentId: String {
        return firestoreDB.collection(HistoryCollectionKeys.CollectionKey).document().documentID
    }

}
