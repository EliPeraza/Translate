//
//  LanguageViewController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
// this is the detailVC
    
    var languages = [String](){
        didSet{
            selectLanguageTableView.reloadData()
        }
    }

  @IBOutlet weak var selectLanguageTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
  }
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
  }
  
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell()
      return cell 
    }
    
    
}
