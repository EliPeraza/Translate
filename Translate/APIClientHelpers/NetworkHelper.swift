//
//  NetworkHelper.swift
//  VenueTips_GroupProject
//
//  Created by Elizabeth Peraza  on 2/8/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class NetworkHelper {
    private init() {}
    static let shared = NetworkHelper()
    func performDataTask(endpointURLString: String,
                         httpMethod: String,
                         httpBody: Data?,
                         handler: @escaping (AppError?, Data?) -> Void) {
        let fixingURL = endpointURLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let unwrappedUrl = fixingURL,
        let url = URL(string: unwrappedUrl) else {
            handler(AppError.badURL(endpointURLString), nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(AppError.networkError(error), nil)
            }
            if let response = response{
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                        handler(AppError.badStatusCode(String(statusCode)), nil)
                        return
                }
            }
            if let data = data {
                handler(nil, data)
            }
        }
        task.resume()
    }
}
