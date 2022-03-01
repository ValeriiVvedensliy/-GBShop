//
//  ProductDescription.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation

struct ProductDescription: Codable {
  let name: String
  let price: Int
  let description: String
  let result: Int
  
  enum CodingKeys: String, CodingKey {
    case name = "product_name"
    case price = "product_price"
    case description = "product_description"
    case result
  }
}
