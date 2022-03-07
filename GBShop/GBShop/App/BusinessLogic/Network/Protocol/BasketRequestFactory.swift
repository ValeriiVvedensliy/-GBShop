//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
  func addProduct(
    productId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  )
  func deleteProduct(
    productId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  )
}
