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
    login: String,
    password: String,
    completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void
  )

  func logout(
    userId: String,
    completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void
  )

  func registerUser(
    login: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void
  )

  func changeUser(
    userId: String,
    login: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String,
    completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void
  )
  
}
