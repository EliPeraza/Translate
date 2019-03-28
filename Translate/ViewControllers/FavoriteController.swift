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
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
            getFavs()
    }
    
    // when i was faving it was not showing in my favs controller 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavs()
    }
    
    private func getFavs() {
        self.myFavorites = UserTransTextFileManager.getFavoriteTranslations()
    }
    
}

extension FavoriteController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError()
        }
        
        let fave = myFavorites[indexPath.row]
        cell.languageEnteredLabel.text = fave.inputLanguageTranslation
        cell.languageTranslatedTo.text = fave.outputLanguageText
        return cell
    }
    
}
extension FavoriteController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexpath = favoriteTableView.indexPathForSelectedRow,
            let DVC = segue.destination as? DetailedController else {
            fatalError("cannot segue to blogDVC")
        }
        DVC.favoriteDetail = myFavorites[indexpath.row]
    }
}
