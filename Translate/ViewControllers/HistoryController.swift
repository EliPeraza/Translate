//
//  HistoryController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class HistoryController: UIViewController {

  
  @IBOutlet weak var historyTableView: UITableView!
    
    private let authservice = AppDelegate.authservice
  
    var history = [History](){
        didSet {
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
            }
        }
    }
    var curentUser: TRUser?
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        historyTableView.refreshControl = rc
        rc.addTarget(self, action: #selector(historyDataLoad), for: .valueChanged)
        return rc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
        title = "Histories"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let curentUser = authservice.getCurrentUser() {
            print("yes")
            refreshControl.beginRefreshing()
            let def = DBService.firestoreDB
                .collection(HistoryCollectionKeys.CollectionKey)
                .document()
            
//            let historyData = History(documentId: def.documentID, createdDate: Date.getISOTimestamp(), userId: curentUser.uid, inputLanguageText: historyData., inputText: "", transLanguagetext: "", transedText: "")
            
            DBService.firestoreDB
                .collection(HistoryCollectionKeys.CollectionKey)
                .addSnapshotListener { [weak self] (snapshot, error) in
                    if let error = error {
                        print("failed to fetch bolg with error: \(error.localizedDescription)")
                    } else if let snapshot = snapshot {
                        self?.history = snapshot.documents.map { History(dict: $0.data()) }
                            .sorted { $0.createdDate.date() > $1.createdDate.date() }
                    }
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                    }
            }
            
//            DBService.historyData(history: historyData) { [weak self] error in
//                if let error = error {
//                    self?.showAlert(title: "History Data Error", message: error.localizedDescription)
//                } else {
//                    self?.dismiss(animated: true)
//                }
//            }

        } else if  curentUser == nil {
            let alert = UIAlertController(title: "Warning", message: "You ONLY get access to Histories when you Login!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                let loginVC = LogInController()
                // self.navigationController?.pushViewController(loginVC, animated: true)
            })
            self.present(alert, animated: true, completion: {
            })
        }
    }
    @objc private func historyDataLoad() {
        guard let user = authservice.getCurrentUser() else {
            print("no logged user")
            return
        }
//        let def = DBService.firestoreDB
//            .collection(HistoryCollectionKeys.CollectionKey)
//            .document()
//  let history = History(documentId: def.documentID, createdDate: Date.getISOTimestamp(), userId: user.uid, inputLanguageText: "", inputText: "", transLanguagetext: "", transedText: "")
//        DBService.historyData(history: history) { [weak self] error in
//            if let error = error {
//                self?.showAlert(title: "History Data Error", message: error.localizedDescription)
//            } else {
//                    self?.dismiss(animated: true)
//                }
//            }
        //}
    }
    
//    private func translateInfo(keyword : String, language: String) {
//        TranslateAPIClient.searchTranslate(keyword: keyword, language: language, completion: { (appError, translate) in
//            if let appError = appError {
//                print(appError.errorMessage())
//            } else if let translate = translate {
//                //                self.translate = translate
//                dump(translate)
//            }
//        })
//    }
//
//
//    private func resultsInfo(keyword: String) {
//        TranslateAPIClient.resultsTranslate(keyword: keyword) { (appError, results) in
//            if let appError = appError {
//                print(appError.errorMessage())
//            } else if let results = results {
//                print(results)
//            }
//        }
//    }

}

extension HistoryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            fatalError("HistoryCell error")
        }
       let histories = history[indexPath.row]
        cell.textEnteredLabel.text = histories.inputText
        cell.textTranslatedLabel.text = histories.transedText
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
