//
//  ProductsCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import Foundation
import RxCocoa

struct ProductsCellModel {
  let id: Int
  let name: String
  let price: Decimal
  let description: String
  let image: String
  let isHiddenButton: Bool
  let buttonTap: PublishRelay<Int>
  let index: Int
}
