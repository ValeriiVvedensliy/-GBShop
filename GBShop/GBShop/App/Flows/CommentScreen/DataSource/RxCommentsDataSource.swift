//
//  RxCommentsDataSource.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import Foundation

import UIKit
import RxDataSources
import Reusable

class RxCommentsDataSource: RxTableViewSectionedReloadDataSource<CommentSectionModel> {
  init() {
    super.init { _, tableView, indexPath, item in
      return RxCommentsDataSource.getCell(item: item, tableView: tableView, indexPath: indexPath)
    }
  }
  
  private static func getCell(
    item: CommentSectionModel.Item,
    tableView: UITableView,
    indexPath: IndexPath
  ) -> UITableViewCell {
    let commentCell = tableView.dequeueReusableCell(for: indexPath) as CommentViewCell
    commentCell.config(item: item)

    return commentCell
  }
}
