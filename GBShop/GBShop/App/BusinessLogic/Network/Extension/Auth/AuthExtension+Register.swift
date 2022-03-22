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
    let method: HTTPMethod = .post
    let path: String = "register"
    let encoding: RequestRouterEncoding = .json

    let login: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
    var parameters: Parameters? {
      return [
        "login": login,
        "password": password,
        "email": email,
        "gender": gender,
        "creditCard": creditCard,
        "bio": bio
      ]
    }
  }
}
