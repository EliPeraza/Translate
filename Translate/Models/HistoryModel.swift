//
//  HistoryModel.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.

import Foundation
// firebase 
struct History {
   
    let documentId: String
    let createdDate: String
    let userId: String
    let inputLanguageText: String
    let inputText: String
    let transLanguagetext: String
    let transedText: String
    
    
    
    init(documentId: String, createdDate: String, userId: String, inputLanguageText: String, inputText: String, transLanguagetext: String, transedText: String) {
        
        self.documentId = documentId
        self.createdDate = createdDate
        self.userId = userId
        self.inputLanguageText = inputLanguageText
        self.inputText = inputText
        self.transLanguagetext = transLanguagetext
        self.transedText = transedText
    }
    
    // used to read a snapshot from firebase - snapshot.data() is a dictionary
    init(dict: [String: Any]) {
        self.documentId = dict[HistoryCollectionKeys.DocumentIdKey] as? String ?? ""
        self.createdDate = dict[HistoryCollectionKeys.CreatedDateKey] as? String ?? ""
        self.userId = dict[HistoryCollectionKeys.UserIdKey] as? String ?? ""
        self.inputLanguageText = dict[HistoryCollectionKeys.InputLanguageText] as? String ?? ""
        self.inputText = dict[HistoryCollectionKeys.InputText] as? String ?? ""
        self.transLanguagetext = dict[HistoryCollectionKeys.TransLanguagetext] as? String ?? ""
        self.transedText = dict[HistoryCollectionKeys.TransedText] as? String ?? ""
    }
}
