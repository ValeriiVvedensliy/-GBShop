//
//  ViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 15.02.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  let request = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    authRequest()
    logoutRequest()
    signUpRequest()
    editProfileRequest()
    getProduct()
    getProducts()
  }
  
  private func authRequest() {
    request.login(userName: "Somebody", password: "mypassword", completionHandler: responseResult)
  }

  private func logoutRequest() {
    request.logout(userId: 123, completionHandler: responseResult)
  }
  
  private func signUpRequest() {
    request.registerUser(
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
    request.changeUser(
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

  private func getProducts() {
    request.getProducts(
      pageNumber: 1,
      categoryId: 123,
      completionHandler: responseResult
    )
  }

  private func getProduct() {
    request.getProduct(
      productId: 123,
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

