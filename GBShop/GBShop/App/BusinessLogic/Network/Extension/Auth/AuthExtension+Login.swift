//
//  AuthExtension+Login.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct Login: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "login"
    
    let login: String
    let password: String
    var parameters: Parameters? {
      return [
        "login": login,
        "password": password
      ]
    }
  }
}
