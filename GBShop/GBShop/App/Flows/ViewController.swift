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
    getComments()
    addComment()
    deleteComment()
    payBasketFlow()
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
      completionHandler: responseResult
    )
  }

  private func getProduct() {
    request.getProduct(
      productId: UUID().uuidString,
      completionHandler: responseResult
    )
  }
  
  private func getComments() {
    request.getComments(
      productId: UUID().uuidString,
      completionHandler: responseResult
    )
  }

  private func addComment() {
    request.addComment(
      productId: UUID().uuidString,
      userId: UUID().uuidString,
      completionHandler: responseResult
    )
  }

  private func deleteComment() {
    request.deleteComment(
      productId: UUID().uuidString,
      commentId: UUID().uuidString,
      completionHandler: responseResult
    )
  }

  private func payBasketFlow() {
    let basket = Basket.shared
    basket.addProduct(product: Product(
      id: 1,
      name: "Айфон",
      price: 38_000,
      description: "телефон",
      url: ""
    ))
    basket.addProduct(product: Product(
      id: 2,
      name: "Mac_Book",
      price: 78_000,
      description: "ноутбук",
      url: ""
    ))
    
    request.payBasket(userId: UUID().uuidString, completionHandler: responseResult)
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

