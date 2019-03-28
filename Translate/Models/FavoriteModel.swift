//
//  FavoriteModel.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
//data persistence 

struct FavoritesModel: Codable {
  
  let inputLanguage: String // inputLanguageText
  let inputLanguageTranslation: String // inputText
  let translanguageText: String // transLanguageText
  let outputLanguageText: String //transedText
  let createdDate: String
}

