//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
  func getProducts(
    pageNumber: Int,
    categoryId: Int,
    completionHandler: @escaping (AFDataResponse<[Product]>) -> Void
  )
  func getProduct(
    productId: Int,
    completionHandler: @escaping (AFDataResponse<ProductDescription>) -> Void
  )
}
