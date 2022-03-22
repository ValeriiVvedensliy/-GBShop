//
//  AuthExtension+Register.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 18.02.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct Register: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .get
    let path: String = "registerUser.json"
    let userId = 123
    
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
    var parameters: Parameters? {
      return [
        "userId": userId,
        "username": username,
        "password": password,
        "email": email,
        "gender": gender,
        "creditCard": creditCard,
        "bio": bio
      ]
    }
  }
}
