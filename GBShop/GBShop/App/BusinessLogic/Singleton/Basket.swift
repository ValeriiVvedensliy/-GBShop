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
    
  public var userId: String = ""
  private var products: [Product] = []
  private init() {}
  
  func addProduct(product: Product) {
    products.append(product)
  }

  func deleteProduct(productId: Int) {
    let index = products.firstIndex { $0.id == productId }
    guard let index = index else { return }

    products.remove(at: index)
  }
  
  func getProductIds() -> [Int]? {
    guard !products.isEmpty else { return nil }

    return products.map({$0.id})
  }
  
  func getProduct() -> [Product]? {
    guard !products.isEmpty else { return nil }

    return products
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
