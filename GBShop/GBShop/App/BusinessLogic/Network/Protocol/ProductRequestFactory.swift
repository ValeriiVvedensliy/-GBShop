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
    categoryId: String,
    completionHandler: @escaping (AFDataResponse<ProductsResponse>) -> Void
  )
  func getProduct(
    productId: String,
    completionHandler: @escaping (AFDataResponse<ProductDescription>) -> Void
  )
}
