//
//  CommentExtension+CommentAdd.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct CommentAdd: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "comment_add"
    
    let productId: String
    let userId: String
    
    var parameters: Parameters? {
      return [
        "productId" : productId,
        "userId": userId
      ]
    }
  }
}
