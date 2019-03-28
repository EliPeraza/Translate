//
//  LogInController.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

enum AccountLoginState {
  case newAccount
  case existingAccount
}

class LogInController: UIViewController {
  
  @IBOutlet weak var userProfilePic: UIImageView!
  
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBOutlet weak var passwordTextfield: UITextField!
  
  @IBOutlet weak var logInButton: UIButton!
  
  @IBOutlet weak var userStatus: UIButton!

  private var accountLoginState = AccountLoginState.newAccount
  
  private var authService = AppDelegate.authservice
  
  override func viewDidLoad() {
    super.viewDidLoad()
    doesUserHaveAccount()
    authService.authserviceCreateNewAccountDelegate = self
    authService.authserviceExistingAccountDelegate = self
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
  
  private func fetchUserInformation() {
    guard let user = authService.getCurrentUser() else {
     print("no logged in user")
      return
    }
    let _ = DBService.firestoreDB
    .collection(TRUserCollectionKeys.CollectionKey)
    .document(user.uid)
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
    
  }
  
  
  func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
    showAlert(title: "SignIn Error", message: error.localizedDescription)
  }
  

  

}

