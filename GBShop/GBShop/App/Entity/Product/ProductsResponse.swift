//
//  Products.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.03.2022.
//

import Foundation

struct ProductsResponse: Codable {
  var result: Int
  var products: [Product]?
}
