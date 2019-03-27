//
//  AuthService.swift
//  Translate
//
//  Created by Elizabeth Peraza  on 3/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthServiceCreateNewAccountDelegate: AnyObject {
  func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error)
  func didCreateNewAccount(_ authservice: AuthService, reviewer: TRUser)
}

protocol AuthServiceExistingAccountDelegate: AnyObject {
  func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error)
  func didSignInToExistingAccount(_ authservice: AuthService, user: User)
}

protocol AuthServiceSignOutDelegate: AnyObject {
  func didSignOutWithError(_ authservice: AuthService, error: Error)
  func didSignOut(_ authservice: AuthService)
}

final class AuthService {
  weak var authserviceCreateNewAccountDelegate: AuthServiceCreateNewAccountDelegate?
  weak var authserviceExistingAccountDelegate: AuthServiceExistingAccountDelegate?
  weak var authserviceSignOutDelegate: AuthServiceSignOutDelegate?
  
  public func createNewAccount(username: String, email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
      if let error = error {
        self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
        return
      } else if let authDataResult = authDataResult {
        
        // update displayName for auth user
        let request = authDataResult.user.createProfileChangeRequest()
        request.displayName = username
        request.commitChanges(completion: { (error) in
          if let error = error {
            self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
            return
          }
        })
        
        // create user (reviewer) on firestore database
        let user = TRUser.init(userId: authDataResult.user.uid,
                               displayName: username,
                               email: authDataResult.user.email!,
                               photoURL: nil,
                               joinedDate: Date.getISOTimestamp())
        DBService.createNDUser(user: user, completion: { (error) in
          if let error = error {
            self.authserviceCreateNewAccountDelegate?.didRecieveErrorCreatingAccount(self, error: error)
          } else {
            self.authserviceCreateNewAccountDelegate?.didCreateNewAccount(self, reviewer: user)
          }
        })
      }
    }
  }
  
  public func signInExistingAccount(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
      if let error = error {
        self.authserviceExistingAccountDelegate?.didRecieveErrorSigningToExistingAccount(self, error: error)
      } else if let authDataResult = authDataResult {
        self.authserviceExistingAccountDelegate?.didSignInToExistingAccount(self, user: authDataResult.user)
      }
    }
  }
  
  public func getCurrentUser() -> User? {
    return Auth.auth().currentUser
  }
  
  public func signOutAccount() {
    do {
      try Auth.auth().signOut()
      authserviceSignOutDelegate?.didSignOut(self)
    } catch {
      authserviceSignOutDelegate?.didSignOutWithError(self, error: error)
    }
  }
}

