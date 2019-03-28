//
//  ViewController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    var autoDetectModeling: AutoDetect!
    var transferedText: TranslateAPIModel!
    
    var language = ["en": "English", "zh": "Chinese", "es": "Spanish", "hi": "Hindi", "de": "German", "ur": "Urdu",
        "bn": "Bengali", "ru": "Russian", "ja": "Japanese", "fr": "French"]
  
  @IBOutlet weak var flagLanguageEntered: UIImageView!
  
  @IBOutlet weak var flagLanguageTranslatedTo: UIImageView!
  
    
    var baseLanguage = ""{
        didSet{
//            flagLanguageEntered.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            baseLanguageButton.setTitle(baseLanguage, for: .normal)
        }
    }
    
    var translateLanguage = ""{
        didSet{
//        flagLanguageTranslatedTo.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            translationLanguageButton.setTitle(translateLanguage, for: .normal)
        }
    }
    var autoDetectedLanguage = ""
    
    
    @IBOutlet weak var baseLanguageButton: UIButton!
    
  
  @IBOutlet weak var translationLanguageButton: UIButton!
  
  @IBOutlet weak var textEnteredByUserToTranslate: UITextView!
  
  
  @IBOutlet weak var translatedTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
  @IBAction func selectBaseLanguageButtonPressed(_ sender: UIButton) {
    //maynot need
  }
  
  @IBAction func selectLanguageToTranslateToButtonPressed(_ sender: UIButton) {
    //maynot Need
  }
  
  
  @IBAction func translateButtonPressed(_ sender: UIButton) {
    
    
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
//                    if let languageFound = auto.lang{
//                        self.baseLanguage = selfgi.language[auto.lang]
//                    }
                }
                
            }
        }
    }
  }
  
  @IBAction func unwindSeque(_ segue: UIStoryboardSegue){
    if segue.identifier == "languageToTranslateTo"{
        if let otherName = language[""]{
            baseLanguage = otherName
        }
    } else if segue.identifier == "baseLanguage"{
    if let fullNameOfLanguage = language["en"]{
        translateLanguage = fullNameOfLanguage
    }
    }
  }
}

extension MainViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "languageToTranslateTo"{
            for key in language{
                
            }
        } else if segue.identifier == "baseLanguage"{
            
        }
    }
}
