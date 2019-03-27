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
    
    var language = ["en": "English", "zh": "Chinese", "es": "Spanish", "hi": "Hindi", "de": "German", "ur": "Urdu",
        "bn": "Bengali", "ru": "Russian", "ja": "Japanese", "fr": "French"]
  
  @IBOutlet weak var flagLanguageEntered: UIImageView!
  
  @IBOutlet weak var flagLanguageTranslatedTo: UIImageView!
  
    
    var baseLanguage = ""{
        didSet{
            flagLanguageEntered.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            baseLanguageButton.setTitle(baseLanguage, for: .normal)
        }
    }
    
    var translateLanguage = ""{
        didSet{
        flagLanguageTranslatedTo.kf.setImage(with: URL(string: "needs to be from the fire base model"), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
            translationLanguageButton.setTitle(translateLanguage, for: .normal)
        }
    }
    var autoDetect = ""
    
    
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
    
  }
  @IBAction func autoDetect(_ sender: UIButton) {
    "the over api goes here Auto Detect"
  }
  
  @IBAction func unwindSeque(_ segue: UIStoryboardSegue){
    if let fullNameOfLanguage = language["en"]{
        
    }
  }
}

extension MainViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ""{
            
        } else if segue.identifier == ""{
            
        }
    }
}
