//
//  ViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 15.02.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  let auth = AppDelegate.container.resolve(Auth.self)!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    authRequest()
    logoutRequest()
    signUpRequest()
    editProfileRequest()
  }
  
  private func authRequest() {
    auth.login(userName: "Somebody", password: "mypassword", completionHandler: responseResult)
  }

  private func logoutRequest() {
    auth.logout(userId: 123, completionHandler: responseResult)
  }
  
  private func signUpRequest() {
    auth.registerUser(
      userName: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language",
      completionHandler: responseResult
    )
  }
  
  private func editProfileRequest() {
    auth.changeUser(
      userId: 123,
      userName: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language",
      completionHandler: responseResult
    )
  }
  
  private func responseResult<T>(response: AFDataResponse<T>) {
    switch response.result {
    case .success(let result):
      print(result)
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}

