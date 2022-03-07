//
//  BasketExtension+Action.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//
import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct BasketAction: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String
    let productId: String
    
    var parameters: Parameters? {
      return [
        "productId" : productId
      ]
    }
  }
}
