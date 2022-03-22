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
    let method: HTTPMethod = .get
    let path: String = "catalogData.json"
    
    let pageNumber: Int
    let categoryId: Int
    
    var parameters: Parameters? {
      return [
        "page_number" : pageNumber,
        "id_category": categoryId
      ]
    }
  }
}
