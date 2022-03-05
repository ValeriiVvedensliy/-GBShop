//
//  CommentExtension+AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory: CommentRequestFactory {
  func getComments(
    productId: String,
    completionHandler: @escaping (AFDataResponse<CommentsResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = Comments(baseUrl: baseUrl, productId: productId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
  
  func addComment(
    productId: String,
    userId: String,
    completionHandler: @escaping (AFDataResponse<CommentActionResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = CommentAdd(baseUrl: baseUrl, productId: productId, userId: userId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
  
  func deleteComment(
    productId: String,
    commentId: String,
    completionHandler: @escaping (AFDataResponse<CommentActionResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = CommentDelete(baseUrl: baseUrl, productId: productId, commentId: commentId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
}

