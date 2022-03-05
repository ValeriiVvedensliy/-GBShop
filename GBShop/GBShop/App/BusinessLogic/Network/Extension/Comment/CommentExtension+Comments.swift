//
//  CommentExtension+Comments.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct Comments: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "comments"
    
    let productId: String
    
    var parameters: Parameters? {
      return [
        "productId" : productId
      ]
    }
  }
}
