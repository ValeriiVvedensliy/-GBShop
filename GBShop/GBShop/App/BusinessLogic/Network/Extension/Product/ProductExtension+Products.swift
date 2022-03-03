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
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "products"
    
    let pageNumber: String
    let categoryId: String
    
    var parameters: Parameters? {
      return [
        "pageNumber" : pageNumber,
        "categoryId": categoryId
      ]
    }
  }
}
