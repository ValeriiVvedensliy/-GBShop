//
//  CommentRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation
import Alamofire

protocol CommentRequestFactory {
  func getComments(
    productId: String,
    completionHandler: @escaping (AFDataResponse<CommentsResponse>) -> Void
  )
  func addComment(
    productId: String,
    userId: String,
    completionHandler: @escaping (AFDataResponse<CommentActionResponse>) -> Void
  )
  func deleteComment(
    productId: String,
    commentId: String,
    completionHandler: @escaping (AFDataResponse<CommentActionResponse>) -> Void
  )
}
