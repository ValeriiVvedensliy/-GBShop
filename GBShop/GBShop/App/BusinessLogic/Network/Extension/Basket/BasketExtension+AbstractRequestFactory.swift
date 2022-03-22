//
//  BasketExtension+AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import Foundation
import Alamofire

extension AbstractRequestFactory: BasketRequestFactory {
  func payBasket(
    userId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  ) {
    guard let baseUrl = baseUrl else { return }
    
    let requestModel = BasketAction(baseUrl: baseUrl, userId: userId)
    self.request(request: requestModel, completionHandler: completionHandler)
  }
}
