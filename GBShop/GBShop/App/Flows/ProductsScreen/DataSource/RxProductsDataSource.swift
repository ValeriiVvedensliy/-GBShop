//
//  RxProductsDataSource.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import Foundation
import UIKit
import RxDataSources
import Reusable

class RxProductsDataSource: RxTableViewSectionedReloadDataSource<ProductsSectionModel> {
  init() {
    super.init { _, tableView, indexPath, item in
      return RxProductsDataSource.getCell(item: item, tableView: tableView, indexPath: indexPath)
    }
  }
  
  private static func getCell(
    item: ProductsSectionModel.Item,
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    let titleCell = tableView.dequeueReusableCell(for: indexPath) as ProductViewCell
    titleCell.config(item: item)

    return titleCell
  }
}
