//
//  CommentSectionModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import Foundation
import RxDataSources

struct CommentSectionModel: Equatable {
  let items: [CommentCellModel]

  init(items: [CommentCellModel]) {
    self.items = items
  }

  static func == (lhs: CommentSectionModel, rhs: CommentSectionModel) -> Bool {
    lhs.items.count == rhs.items.count
  }
}

extension CommentSectionModel: SectionModelType {
  typealias Item = CommentCellModel

  init(original: Self, items: [Self.Item]) {
    self = original
  }
}
