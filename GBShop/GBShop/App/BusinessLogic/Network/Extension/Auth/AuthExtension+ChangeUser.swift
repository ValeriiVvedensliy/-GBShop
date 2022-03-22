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
    let method: HTTPMethod = .post
    let path: String = "change"
    let encoding: RequestRouterEncoding = .json
    
    let userId: String
    let login: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
    var parameters: Parameters? {
      return [
        "userId": userId,
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
