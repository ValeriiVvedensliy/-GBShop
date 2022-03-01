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
    let method: HTTPMethod = .get
    let path: String = "getGoodById.json"
    let productId: Int

    var parameters: Parameters? {
      return [
        "id_product" : productId
      ]
    }
  }
}


