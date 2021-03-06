//
//  ViewController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

enum languageForButton{
  case baseLanguage
  case translatedLanguage
}


class MainViewController: UIViewController {
  
  var autoDetectModeling: AutoDetect!
  var authSession = AppDelegate.authservice
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
  
  
  var baseLanguage = "English"{
    didSet{
      DispatchQueue.main.async {
        self.flagLanguageEntered.image = UIImage.init(named: (self.language.allKeysForValue(val: self.baseLanguage)?.first)!)
        self.baseLanguageButton.setTitle(self.baseLanguage, for: .normal)
      }
    }
  }
  
  var translateLanguage = "Spanish"{
    didSet{

      DispatchQueue.main.async{
        self.flagLanguageTranslatedTo.image = UIImage.init(named: (self.language.allKeysForValue(val: self.translateLanguage)?.first)!)
        self.translationLanguageButton.setTitle(self.translateLanguage, for: .normal)
      }
    }
  }
  var autoDetectedLanguage = "en"
  
  @IBOutlet weak var baseLanguageButton: UIButton!
  
  
  @IBOutlet weak var translationLanguageButton: UIButton!
  
  @IBOutlet weak var textEnteredByUserToTranslate: UITextView!
  
  @IBOutlet weak var textToSpeechButton: CornerButton!
  
  @IBOutlet weak var translatedTextLabel: UILabel!
  
  private var textViewPlaceHolder = "Enter text you want to translate"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Translate"
    configureTextView()
            self.flagLanguageEntered.image = UIImage.init(named: (self.language.allKeysForValue(val: self.baseLanguage)?.first)!)
            self.flagLanguageTranslatedTo.image = UIImage.init(named: (self.language.allKeysForValue(val: self.translateLanguage)?.first)!)
  }
  
  private func configureTextView() {
    textEnteredByUserToTranslate.delegate = self
    textEnteredByUserToTranslate.text = textViewPlaceHolder
    textEnteredByUserToTranslate.textColor = .lightGray
    textEnteredByUserToTranslate.returnKeyType = .done
  }
  
  @IBAction func textToSpeechButtonPressed(_ sender: UIButton) {
    if let string = translatedTextLabel.text{
      let utterance = AVSpeechUtterance(string: string)
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
      let synth = AVSpeechSynthesizer()
      synth.speak(utterance)
    }
    else{
      showAlert(title: "Problem", message: "nothing to translate")
    }
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
            if let user = self.authSession.getCurrentUser(){
              let docRef = DBService.firestoreDB.collection(HistoryCollectionKeys.CollectionKey)
                .document()
              let history = History(documentId: docRef.documentID, createdDate: Date.getISOTimestamp(), userId: user.uid, inputLanguageText: self.baseLanguage, inputText: textToTranslate, transLanguagetext: self.translateLanguage, transedText: self.transferedText.text.first!)
              DBService.historyData(history: history) { (error) in
                if let error = error{
                  self.showAlert(title: "Problem", message: error.localizedDescription)
                }else{
                  print("saved")
                }
              }
            }
          }
        }
        
        
      }else{
        self.showAlert(title: "Problem", message: "No text entered to translate")
      }
    }else{
      showAlert(title: "Problem", message: "enter some text, or select a language")
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

extension MainViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == textViewPlaceHolder {
      textView.text = ""
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      textView.text = textViewPlaceHolder
      textView.textColor = .lightGray
    }
  }

  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if (text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
}

