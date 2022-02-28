//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
  func login(
    userName: String,
    password: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  )

  func logout(
    userId: Int,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  )

  func registerUser(
    userName: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  )

  func changeUser(
    userId: Int,
    userName: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  )
  
}
