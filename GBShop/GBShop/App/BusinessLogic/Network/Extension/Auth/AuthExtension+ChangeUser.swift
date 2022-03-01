//
//  AuthExtension+ChangeUser.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 18.02.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct ChangeUser: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .get
    let path: String = "changeUserData.json"
    
    let userId: Int
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
