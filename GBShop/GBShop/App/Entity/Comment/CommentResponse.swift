//
//  CommentResponse.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation

struct CommentsResponse: Codable {
  var result: Int
  var comments: [Comment]?
}
