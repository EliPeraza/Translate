//
//  APIClient.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class TranslateAPIClient {
    
    static func searchTranslate(keyword: String, language: String, completion: @escaping (AppError?, TranslateAPIModel?) -> Void) {
        
        NetworkHelper.shared.performDataTask(endpointURLString: "https://translate.yandex.net/api/v1.5/tr.json/translate?lang=\(language)&key=\(SecretKeys.translateKey)&text=\(keyword)", httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completion(appError, nil)
            } else if let data = data {
                do {
                    let translateData = try JSONDecoder().decode(TranslateAPIModel.self, from: data)
                    completion(nil, translateData)
                    
                } catch {
                    completion(appError, nil)
                    
                }
            }
        }
    }
    
    static func resultsTranslate(keyword: String, completion: @escaping (AppError?, TranslateAPIModel?) -> Void) {
        
        NetworkHelper.shared.performDataTask(endpointURLString: "https://translate.yandex.net/api/v1.5/tr.json/detect?key=\(SecretKeys.translateKey)&text=\(keyword)", httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completion(appError, nil)
            }
            if let data = data {
                do {
                    let resultsData = try JSONDecoder().decode(TranslateAPIModel.self, from: data)
                    
                    completion(nil, resultsData)
                } catch {
                    completion(appError, nil)
                    
                }
            }
        }
    }
}
