//
//  BasketExtension+AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory: BasketRequestFactory {
  func addProduct(
    productId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = BasketAction(baseUrl: baseUrl, path: Constants.basketAddAction, productId: productId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
  
  func deleteProduct(
    productId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = BasketAction(baseUrl: baseUrl, path: Constants.basketDeleteAction, productId: productId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
}

private enum Constants {
  // Strings
  static let basketAddAction = "product_add"
  static let basketDeleteAction = "product_delete"
}
