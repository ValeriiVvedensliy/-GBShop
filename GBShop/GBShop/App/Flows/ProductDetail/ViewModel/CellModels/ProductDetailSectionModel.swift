//
//  ProductDetailSectionModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import Foundation
import RxDataSources

struct ProductDetailSectionModel: Equatable {
  let items: [ProductDetailCellModel]

  init(items: [ProductDetailCellModel]) {
    self.items = items
  }

  static func == (lhs: ProductDetailSectionModel, rhs: ProductDetailSectionModel) -> Bool {
    lhs.items.count == rhs.items.count
  }
}

extension ProductDetailSectionModel: SectionModelType {
  typealias Item = ProductDetailCellModel

  init(original: Self, items: [Self.Item]) {
    self = original
  }
}
