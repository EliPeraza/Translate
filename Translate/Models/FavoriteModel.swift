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
    
    let languageInput: String
    let languageTranslation: String
    let inputText: String
    let transLanguageText: String
    let createdDate: String 

}
