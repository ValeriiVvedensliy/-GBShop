//
//  ProductsTableViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import RxFlow
import Reusable

class ProductsTableViewController: UITableViewController {
  lazy var dataSource = RxProductsDataSource()
  private let disposeBag = DisposeBag()
  public var viewModel: ProductsViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()

      registerNib()
      setUpView()
      setupBindings()
    }
  
  // MARK: - Bindings
  private func setupBindings() {
    viewModel?.output.source
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
  
  private func setUpView() {
    view.backgroundColor = Constants.viewBackgroundColor
    tableView.backgroundColor = Constants.tableViewBackgroundColor
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
    tableView.keyboardDismissMode = .interactive
    tableView.dataSource = nil
    tableView.delegate = nil
  }

  private func registerNib() {
    tableView.register(cellType: ProductViewCell.self)
  }
}

private enum Constants {
  // Colors
  static let viewBackgroundColor = UIColor.Purple
  static let tableViewBackgroundColor = UIColor.Purple
  
  // Sizes
  static let tableViewEstimatedRowHeight: CGFloat = 150
}
