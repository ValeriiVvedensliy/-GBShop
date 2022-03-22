//
//  BasketExtension+Action.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//
import Foundation
import Alamofire

extension AbstractRequestFactory {
  struct BasketAction: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod = .post
    let path = "pay_product"
    let userId: String
    let products = Basket.shared.getProductIds() ?? []
    let cash = Basket.shared.getPrice() ?? 0
    let encoding: RequestRouterEncoding = .json
    
    var parameters: Parameters? {
      return [
        "userId" : userId,
        "productsId" : products,
        "cash" : cash
      ]
    }
  }
}
