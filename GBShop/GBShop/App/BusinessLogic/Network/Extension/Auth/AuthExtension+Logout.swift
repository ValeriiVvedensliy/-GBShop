//
//  AuthExtension+Logout.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct Logout: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "logout"
    
    let userId: String
    var parameters: Parameters? {
      return [
        "userId": userId
      ]
    }
  }
}
