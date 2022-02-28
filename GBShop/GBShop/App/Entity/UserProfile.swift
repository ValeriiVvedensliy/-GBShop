//
//  UserProfile.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 28.02.2022.
//

import Foundation

struct UserProfile: Codable {
  let id: Int
  let name: String
  let password: String
  let email: String
  let gender: String
  let creditCard: String
  let bio: String
}
