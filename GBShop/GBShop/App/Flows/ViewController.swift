//
//  ViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 15.02.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let auth = AppDelegate.container.resolve(Auth.self)!
    
//    auth.login(userName: "Somebody", password: "mypassword", completionHandler: responseResult)
//    auth.logout(userId: 123, completionHandler: responseResult)
//    auth.registerUser(
//      userName: "Somebody",
//      password: "mypassword",
//      email: "some@some.ru",
//      gender: "m",
//      creditCard: "9872389-2424-234224-234",
//      bio: "This is good! I think I will switch to another language",
//      completionHandler: responseResult
//    )
//    auth.changeUser(
//      userId: 123,
//      userName: "Somebody",
//      password: "mypassword",
//      email: "some@some.ru",
//      gender: "m",
//      creditCard: "9872389-2424-234224-234",
//      bio: "This is good! I think I will switch to another language",
//      completionHandler: responseResult
//    )
//  }
//
//  private func responseResult(response: AFDataResponse<LoginResult>) {
//    switch response.result {
//    case .success(let login):
//      print(login)
//    case .failure(let error):
//      print(error.localizedDescription)
//    }
//  }
}

