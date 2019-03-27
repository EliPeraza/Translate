//
//  ViewController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var flagLanguageEntered: UIImageView!
  
  @IBOutlet weak var flagLanguageTranslatedTo: UIImageView!
  
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
    
  }
  
  @IBAction func unwindSeque(_ segue: UIStoryboardSegue){
    
  }
}

