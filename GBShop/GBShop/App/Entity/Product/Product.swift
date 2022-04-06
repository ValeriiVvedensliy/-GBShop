//
//  Product.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation

struct Product: Codable {
  let id: Int
  let name: String
  let price: Decimal
  let description: String
  let url: String
}
