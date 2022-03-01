//
//  ProductExtension+AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory: ProductRequestFactory {
  func getProducts(
    pageNumber: Int,
    categoryId: Int,
    completionHandler: @escaping (AFDataResponse<[Product]>) -> Void) {
      guard let baseUrl = baseUrl else { return }

      let requestModel = Products(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
      self.request(request: requestModel, completionHandler: completionHandler)
    }
  
  func getProduct(
    productId: Int,
    completionHandler: @escaping (AFDataResponse<ProductDescription>) -> Void) {
      guard let baseUrl = baseUrl else { return }

      let requestModel = ProductsDetail(baseUrl: baseUrl, productId: productId)
      self.request(request: requestModel, completionHandler: completionHandler)
    }
}

