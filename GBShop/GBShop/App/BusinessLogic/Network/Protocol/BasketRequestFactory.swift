//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
  func payBasket(
    userId: String,
    completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void
  )
}
