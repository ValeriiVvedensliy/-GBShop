//
//  ProductsSectionModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import Foundation
import RxDataSources

struct ProductsSectionModel: Equatable {
  let items: [ProductsCellModel]

  init(items: [ProductsCellModel]) {
    self.items = items
  }

  static func == (lhs: ProductsSectionModel, rhs: ProductsSectionModel) -> Bool {
    lhs.items.count == rhs.items.count
  }
}

extension ProductsSectionModel: SectionModelType {
  typealias Item = ProductsCellModel

  init(original: Self, items: [Self.Item]) {
    self = original
  }
}
