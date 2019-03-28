//
//  FavoriteController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {
  
  @IBOutlet weak var favoriteTableView: UITableView!
  
    private var myFavorites = [FavoritesModel]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        return cell 
    }
    
    
}
