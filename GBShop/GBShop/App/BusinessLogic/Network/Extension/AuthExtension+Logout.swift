//
//  AuthExtension+Logout.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

extension Auth {
  struct Logout: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .get
    let path: String = "logout.json"
    
    let userId: Int
    var parameters: Parameters? {
      return [
        "userId": userId
      ]
    }
  }
}
