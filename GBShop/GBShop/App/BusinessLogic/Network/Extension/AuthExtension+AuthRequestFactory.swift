//
//  AuthExtension+AuthRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

extension Auth: AuthRequestFactory {
  func login(
    userName: String,
    password: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }

    let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
    self.request(request: requestModel, completionHandler: completionHandler)
  }

  func logout(
    userId: Int,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }

    let requestModel = Logout(baseUrl: baseUrl, userId: userId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }

  func registerUser(
    userName: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }

    let requestModel = Register(
      baseUrl: baseUrl,
      username: userName,
      password: password,
      email: email,
      gender: gender,
      creditCard: creditCard,
      bio: bio
    )
    self.request(request: requestModel, completionHandler: completionHandler)
  }

  func changeUser(
    userId: Int,
    userName: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }

    let requestModel = ChangeUser(
      baseUrl: baseUrl,
      userId: userId,
      username: userName,
      password: password,
      email: email,
      gender: gender,
      creditCard: creditCard,
      bio: bio
    )
    self.request(request: requestModel, completionHandler: completionHandler)
  }
}
