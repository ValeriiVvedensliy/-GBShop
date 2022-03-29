//
//  ProductExtension+Products.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct Products: RequestRouter {
    var parameters: Parameters? {
      return [:]
    }
    
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "products"
    let encoding: RequestRouterEncoding = .json
  }
}
