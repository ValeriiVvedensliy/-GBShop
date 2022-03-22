//
//  LoginResult.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation

struct LoginResult: Codable {
  var result: Int
  var user: User?
  var userMessage: String?
}
