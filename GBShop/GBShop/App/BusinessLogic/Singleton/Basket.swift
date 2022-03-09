//
//  Basket.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import Foundation
import Alamofire

class Basket {
  static var shared: Basket = {
    let instance = Basket()

    return instance
  }()
    
  private var products: [Product] = []
  private init() {}
  
  func addProduct(product: Product) {
    products.append(product)
  }

  func deleteProduct(product: Product) {
    let index = products.firstIndex { $0.id == product.id }
    guard let index = index else { return }

    products.remove(at: index)
  }
  
  func getProductIds() -> [Int]? {
    guard !products.isEmpty else { return nil }

    return products.map({$0.id})
  }
  
  func getPrice() -> Decimal? {
    guard !products.isEmpty else { return nil }

    var cash: Decimal = 0
    products.forEach { cash = cash + $0.price }
    return cash
  }
  
  func defaultState() {
    products.removeAll()
  }
}
