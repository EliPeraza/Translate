//
//  DataPersistenceManager.swift
//  VenueTips_GroupProject
//
//  Created by Elizabeth Peraza  on 2/8/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class DataPersistenceManager {
        private init() {}
        
        static func documentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
        
        static func filepathToDocumentsDirectory(filename: String) -> URL {
            return documentsDirectory().appendingPathComponent(filename)
        }
    }
    
final class UserTransTextFileManager {
    
    static let filenameForTrans = "UserTransList.plist"
    private static var transItems = [FavoritesModel]()
    
    private init() {}
    
    static func saveFavoriteTranslations() {
        let pathURL = DataPersistenceManager.filepathToDocumentsDirectory(filename: filenameForTrans)
        let pathString = pathURL.path
        print("I have a path: \(pathURL)")
        
        do {
            let data = try PropertyListEncoder().encode(transItems)
            try data.write(to: pathURL, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }

    static func getFavoriteTranslations() -> [FavoritesModel] {
        let pathURL = DataPersistenceManager.filepathToDocumentsDirectory(filename: filenameForTrans)
        let pathString = pathURL.path
        
        if FileManager.default.fileExists(atPath: pathString) {
            if let data = FileManager.default.contents(atPath: pathString) {
                do {
                    transItems = try
                        PropertyListDecoder().decode([FavoritesModel].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
        } else {
            print("getFavoritedTransText data is nil")
        }
    } else {
            print("\(filenameForTrans) does not exist")
        }
        transItems = transItems.sorted{$0.createdDate.date() > $1.createdDate.date()}
        return transItems
    }

    static func addEntry(transText: FavoritesModel) {
        transItems.append(transText)
        saveFavoriteTranslations()
    }

    static func delete(atIndex index: Int) {
        transItems.remove(at: index)
        saveFavoriteTranslations()
    }
}
