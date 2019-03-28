//
//  HistoryController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UITabBarControllerDelegate {

  
  @IBOutlet weak var historyTableView: UITableView!
  
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
        self.tabBarController?.delegate = self
        title = "Histories"
    }
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex == 1{
            //tabBarController.selectedIndex = 1
            let alert = UIAlertController(title: "Warning", message: "You ONLY get access to Histories when you Login!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                let loginVC = LogInController()
                self.navigationController?.pushViewController(loginVC, animated: true)
            })
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    
    private func translateInfo(keyword : String, language: String) {
        TranslateAPIClient.searchTranslate(keyword: keyword, language: language, completion: { (appError, translate) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let translate = translate {
                //                self.translate = translate
                dump(translate)
            }
        })
    }
    
    
    private func resultsInfo(keyword: String) {
        TranslateAPIClient.resultsTranslate(keyword: keyword) { (appError, results) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let results = results {
                print(results)
            }
        }
    }

}

extension HistoryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            fatalError("HistoryCell error")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
