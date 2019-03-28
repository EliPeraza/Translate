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
         fetchHistories()
    }
    
    func fetchHistories() {
        refreshControl.beginRefreshing()
        guard let user = authservice.getCurrentUser() else {
                let alert = UIAlertController(title: "Warning", message: "You ONLY get access to Histories when you Login!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
//                    let loginVC = LogInController()
//                    self.navigationController?.pushViewController(loginVC, animated: true)
                })
                self.present(alert, animated: true, completion: {
                })
            return
        }
        let def = DBService.firestoreDB
            .collection(HistoryCollectionKeys.CollectionKey)
            .document()
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
    }
    

    @objc private func historyDataLoad() {
        guard let user = authservice.getCurrentUser() else {
            print("no logged user")
            return
        }

    }
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
        cell.favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
    
        
        return cell
    }
    @objc func addFavorite() {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constants.HistoryCellHeight
    }
}
