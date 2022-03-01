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
    let method: HTTPMethod = .get
    let path: String = "login.json"
    
    let login: String
    let password: String
    var parameters: Parameters? {
      return [
        "username": login,
        "password": password
      ]
    }
  }
}
