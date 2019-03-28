//
//  DetailedController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class DetailedController: UIViewController {

  
  @IBOutlet weak var flagLanguageEntered: UIImageView!
  
  @IBOutlet weak var titleLanguageEntered: UILabel!
  
  @IBOutlet weak var textEntered: UITextView!
  
  
  @IBOutlet weak var flagLanguageTranslatedTo: UIImageView!
  
  @IBOutlet weak var titleLanguageTranslatedTo: UILabel!
  
  @IBOutlet weak var textTranslated: UITextView!
  
    var historyDetail: History!
  
    var inputText: String?
    var transText: String?
    var inputTitleLanguage: String?
    var transTitleLanguage: String?
    
  override func viewDidLoad() {
        super.viewDidLoad()

    titleLanguageTranslatedTo.text = historyDetail.transLanguagetext
    titleLanguageEntered.text = historyDetail.inputLanguageText
    textEntered.text = historyDetail.inputText
    textTranslated.text = historyDetail.transedText
    
    
    }
    

}
