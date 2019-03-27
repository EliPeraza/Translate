//
//  TranslateAPIModel.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
//api
struct TranslateAPIModel: Codable {
    let lang: String
    let text: [String]
}
