//
//  LogInController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import Firebase
import Toucan
import Kingfisher

enum AccountLoginState {
  case newAccount
  case existingAccount
}

class LogInController: UIViewController {
  
  
  @IBOutlet weak var userProfileButtonPicture: UIButton!
  
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBOutlet weak var passwordTextfield: UITextField!
  
  @IBOutlet weak var logInButton: UIButton!
  
  @IBOutlet weak var userStatus: UIButton!

  private var accountLoginState = AccountLoginState.newAccount
  
  private var authService = AppDelegate.authservice
  private var selectedImage: UIImage?
  
  private lazy var imagePickerController: UIImagePickerController = {
    let ip = UIImagePickerController()
    ip.delegate = self
    return ip
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTextFields()
    authService.authserviceCreateNewAccountDelegate = self
    authService.authserviceExistingAccountDelegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    updateProfileUI()
  }
  
  
  private func setUpTextFields() {
    emailTextField.delegate = self
    passwordTextfield.delegate = self
    emailTextField.placeholder = "enter email here (e.g. john@john.com)"
    passwordTextfield.placeholder = "enter password here (e.g. john123)"
  }
  
  private func doesUserHaveAccount() {
    accountLoginState = accountLoginState == .newAccount ? .existingAccount : .newAccount
    switch accountLoginState {
    case .newAccount:
      logInButton.setTitle("Create", for: .normal)
      userStatus.setTitle("Log in to your account", for: .normal)
    case .existingAccount:
      logInButton.setTitle("Login", for: .normal)
      userStatus.setTitle("New user account? Create an account", for: .normal)
    }
  }
  
  private func updateProfileUI() {
    guard let user = authService.getCurrentUser() else {
     print("no logged in user")
      return
    }
    DBService.fetchUser(userId: user.uid) { (error, user) in
      if let user = user {
        self.emailTextField.text = user.email
      }
      guard let photoURL = user?.photoURL,
        !photoURL.isEmpty else {
       print("couldn't find photo")
          return
      }
      self.userProfileButtonPicture.kf.setImage(with: URL(string: photoURL), for: .normal)
    }
  }
  
  @IBAction func logInButtonPressed(_ sender: UIButton) {
    guard let email = emailTextField.text,
      !email.isEmpty,
      let passWord = passwordTextfield.text,
      !passWord.isEmpty else {
        showAlert(title: "Missing fields", message: "Please fill all the fields")
        return
    }
    switch accountLoginState {
    case .newAccount:
      authService.createNewAccount(email: email, password: passWord)
    case .existingAccount:
      authService.signInExistingAccount(email: email, password: passWord)
    }
  }
  
  @IBAction func imageButtonPressed(_ sender: UIButton) {
    
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
      self.imagePickerController.sourceType = .camera
      self.showImagePickerController()
    }
    let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
      self.imagePickerController.sourceType = .photoLibrary
      self.showImagePickerController()
    }
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      alertController.addAction(cameraAction)
    }
    alertController.addAction(photoLibrary)
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    self.present(alertController, animated: true)
    
    
  }
  
  private func showImagePickerController() {
    present(imagePickerController, animated: true, completion: nil)
  }
  
  
  @IBAction func switchAccountButtonPressed(_ sender: UIButton) {
    doesUserHaveAccount()

  }
}




extension LogInController: AuthServiceCreateNewAccountDelegate{
  func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error) {
    showAlert(title: "Error creating account", message: "Try again")
  }
  
  func didCreateNewAccount(_ authservice: AuthService, reviewer: TRUser) {
    showAlert(title: "Created account!", message: "An account was created using \(emailTextField.text ?? "no email entered")")
  }
}

extension LogInController: AuthServiceExistingAccountDelegate {
  func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
    showAlert(title: "Welcome!", message: "You are logged in")
  }
  
  
  func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
    showAlert(title: "SignIn Error", message: error.localizedDescription)
  }

}

extension LogInController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      print("original image not available")
      return
    }
    let size = CGSize(width: 500, height: 500)
    let resizedImage = Toucan.Resize.resizeImage(originalImage, size: size)
    selectedImage = resizedImage
    userProfileButtonPicture.setImage(resizedImage, for: .normal)
    dismiss(animated: true)
  }
}

extension LogInController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.becomeFirstResponder()
    if textField.text == textField.placeholder {
      textField.text = ""
      textField.textColor = .black
    }
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField.text == "" {
      textField.text = textField.placeholder
      textField.textColor = .lightGray
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
