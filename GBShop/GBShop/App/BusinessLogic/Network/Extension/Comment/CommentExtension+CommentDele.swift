//
//  CommentExtension+CommentDele.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct CommentDelete: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path: String = "comment_delete"
    
    let productId: String
    let commentId: String
    
    var parameters: Parameters? {
      return [
        "productId" : productId,
        "commentId": commentId
      ]
    }
  }
}
