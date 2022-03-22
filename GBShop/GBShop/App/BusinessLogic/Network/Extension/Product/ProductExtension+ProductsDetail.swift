//
//  ProductExtension+ProductsDetail.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct ProductsDetail: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "product"
    let productId: String

    var parameters: Parameters? {
      return [
        "productId" : productId
      ]
    }
  }
}


