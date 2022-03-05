//
//  CommentActionResponse.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.03.2022.
//

import Foundation

struct CommentActionResponse: Codable {
  var result: Int
  var commentId: String?
  var message: String?
}
