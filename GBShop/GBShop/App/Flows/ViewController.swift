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
    request.login(login: "valerii", password: "02299394", completionHandler: responseResult)
  }

  private func logoutRequest() {
    request.logout(userId: UUID().uuidString, completionHandler: responseResult)
  }
  
  private func signUpRequest() {
    request.registerUser(
      login: "valerii",
      password: "02299394",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language",
      completionHandler: responseResult
    )
  }
  
  private func editProfileRequest() {
    request.changeUser(
      userId: UUID().uuidString,
      login: "Somebody",
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
      pageNumber: "1",
      categoryId: "123",
      completionHandler: responseResult
    )
  }

  private func getProduct() {
    request.getProduct(
      productId: UUID().uuidString,
      completionHandler: responseResult
    )
  }
  
  private func responseResult<T>(response: AFDataResponse<T>) {
    switch response.result {
    case .success(let result):
      print("\(result) \n")
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}

