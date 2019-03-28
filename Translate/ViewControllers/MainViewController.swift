//
//  ViewController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import Kingfisher

enum languageForButton{
    case baseLanguage
    case translatedLanguage
}


class MainViewController: UIViewController {
    
    var autoDetectModeling: AutoDetect!
    var transferedText: TranslateAPIModel!{
        didSet{
            DispatchQueue.main.async {
                self.translatedTextLabel.text = self.transferedText.text.first ?? "No text was found"
            }
        }
    }
    
    var caseOfButton = languageForButton.baseLanguage
    
    var language = ["en": "English", "zh": "Chinese", "es": "Spanish", "hi": "Hindi", "de": "German", "ur": "Urdu",
        "bn": "Bengali", "ru": "Russian", "ja": "Japanese", "fr": "French"]
  
  @IBOutlet weak var flagLanguageEntered: UIImageView!
  
  @IBOutlet weak var flagLanguageTranslatedTo: UIImageView!
  
    
    var baseLanguage = "Spanish"{
        didSet{
//            flagLanguageEntered.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            DispatchQueue.main.async {
                self.baseLanguageButton.setTitle(self.baseLanguage, for: .normal)
            }
        }
    }
    
    var translateLanguage = "English"{
        didSet{
//        flagLanguageTranslatedTo.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            DispatchQueue.main.async{
                self.translationLanguageButton.setTitle(self.translateLanguage, for: .normal)
            }
        }
    }
    var autoDetectedLanguage = "en"
    
    @IBOutlet weak var baseLanguageButton: UIButton!
    
  
  @IBOutlet weak var translationLanguageButton: UIButton!
  
  @IBOutlet weak var textEnteredByUserToTranslate: UITextView!
  
  
  @IBOutlet weak var translatedTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
  @IBAction func selectBaseLanguageButtonPressed(_ sender: UIButton) {
    
  }
  
  @IBAction func selectLanguageToTranslateToButtonPressed(_ sender: UIButton) {
    
  }
  
  
  @IBAction func translateButtonPressed(_ sender: UIButton) {
    if let textToTranslate = textEnteredByUserToTranslate.text,
        let base = language.allKeysForValue(val: baseLanguage),
        let trans = language.allKeysForValue(val: translateLanguage){
        if !textToTranslate.isEmpty{
            TranslateAPIClient.searchTranslate(keyword: textToTranslate, language: "\(base.first!)-\(trans.first!)") { (error, model) in
                if let error = error{
                    self.showAlert(title: "error", message: error.errorMessage())
                }else if let model = model{
                    self.transferedText = model
                }
            }
        }else{
            self.showAlert(title: "Problem", message: "No text entered to translate")
        }
    }
    
  }
  @IBAction func autoDetect(_ sender: UIButton) {
    if let text = textEnteredByUserToTranslate.text{
        if text.isEmpty{
            showAlert(title: "No fields Enterd", message: "Give me some data to work with")
        }else{
            TranslateAPIClient.resultsTranslate(keyword: text) { (error, auto) in
                if let error = error{
                    self.showAlert(title: "error", message: error.localizedDescription)
                    
                }else if let auto = auto{
                    if let lang = self.language[auto.lang]{
                        DispatchQueue.main.async {
                            self.baseLanguage = lang
                        }
                    }
                }else{
                    self.showAlert(title: "Language not supported", message: nil)
                }
                
            }
        }
    }
  }
  
  @IBAction func unwindSeque(_ segue: UIStoryboardSegue){
    let languageVC = segue.source as! LanguageViewController
    switch caseOfButton {
    case .baseLanguage:
        self.baseLanguage = languageVC.languagedSelected
        baseLanguageButton.setTitle(languageVC.languagedSelected, for: .normal)
    case .translatedLanguage:
        self.translateLanguage = languageVC.languagedSelected
        translationLanguageButton.setTitle(languageVC.languagedSelected, for: .normal)
    }
  }
}

extension MainViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "languageToTranslateTo"{
            caseOfButton = languageForButton.baseLanguage
            var languagedToTransfer = [String]()
           guard let languageDVC = segue.destination as? LanguageViewController else {
                fatalError("cannot segue to DVC")
            }
            for (_,value) in language{
                languagedToTransfer.append(value)
            }
            languageDVC.languages = languagedToTransfer
            languagedToTransfer.removeAll()
        } else if segue.identifier == "baseLanguage"{
            caseOfButton = languageForButton.translatedLanguage
            var languagedToTransfer = [String]()
            guard let languageDVC = segue.destination as? LanguageViewController else {
                fatalError("cannot segue to DVC")
            }
            for (_,value) in language{
                languagedToTransfer.append(value)
            }
            languageDVC.languages = languagedToTransfer
            languagedToTransfer.removeAll()
        }
    }
}


extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key]? {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
