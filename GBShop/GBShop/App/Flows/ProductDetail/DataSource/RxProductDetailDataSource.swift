//
//  RxProductDetailDataSource.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 31.03.2022.
//

import Foundation
import UIKit
import RxDataSources
import Reusable

class RxProductDetailDataSource: RxTableViewSectionedReloadDataSource<ProductDetailSectionModel> {
  init() {
    super.init { _, tableView, indexPath, item in
      switch indexPath.row {
      case 0:
        return RxProductDetailDataSource.getImageCell(item: item, tableView: tableView, indexPath: indexPath)

      case 1...3:
        return RxProductDetailDataSource.getTextCell(item: item, tableView: tableView, indexPath: indexPath)

      case 4:
        return RxProductDetailDataSource.getCommentCell(item: item, tableView: tableView, indexPath: indexPath)

      default:
        return UITableViewCell()
      }
    }
  }

  private static func getImageCell(
    item: ProductDetailSectionModel.Item,
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    guard let item = item as? ProductImageCellModel else { return UITableViewCell() }

    let titleCell = tableView.dequeueReusableCell(for: indexPath) as ProductScreenViewCell

    titleCell.config(item: item)

    return titleCell
  }

  private static func getTextCell(
    item: ProductDetailSectionModel.Item,
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    guard let item = item as? ProductTextCellModel else { return UITableViewCell() }

    let textCell = tableView.dequeueReusableCell(for: indexPath) as ProductTextViewCell
    textCell.config(item: item)

    return textCell
  }

  private static func getCommentCell(
    item: ProductDetailSectionModel.Item,
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    guard let item = item as? ProductDetailCommentModel else { return UITableViewCell() }

    let buttonCell = tableView.dequeueReusableCell(for: indexPath) as ProductCommentViewCell

    buttonCell.config(item: item)

    return buttonCell
  }

}
