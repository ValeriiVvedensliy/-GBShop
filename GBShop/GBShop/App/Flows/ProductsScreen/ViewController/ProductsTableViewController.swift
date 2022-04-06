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
  public var viewModel: ProductsViewModel!
        
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
    
    tableView.rx.itemSelected
      .bind(to: viewModel.indexOfSelectedCell)
      .disposed(by: disposeBag)
  }
  
  private func setUpView() {
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton())
    setUpNavigationBarTitle()
    setUpNavigationBarRightButton()
    view.backgroundColor = Constants.viewBackgroundColor
    tableView.backgroundColor = Constants.tableViewBackgroundColor
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = .White
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
    tableView.keyboardDismissMode = .interactive
    tableView.dataSource = nil
    tableView.delegate = nil
    
    tableView.isAccessibilityElement = true
    tableView.accessibilityIdentifier = "ProductsScreen"
  }
  
  private func setUpNavigationBarTitle() {
    let titleLabel = UILabel()
    titleLabel.attributedText = "Products".aligmentAttributedString(
      foreground: .White,
      aligment: .center,
      sketchLineHeight: 22,
      fontSize: 19
    );
    
    navigationItem.titleView = titleLabel
  }
  
  private func setUpNavigationBarRightButton() {
    let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 58, height: 32))
    rightBtn.backgroundColor = Constants.buttonTintColor
    rightBtn.layer.cornerRadius = rightBtn.frame.height / 2
    rightBtn.setTitle("Basket", for: .normal)
    rightBtn.setTitleColor(.white, for: .normal)
    rightBtn.rx.tap
      .bind(to: viewModel.input.onBasketTap)
      .disposed(by: disposeBag)

    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
  }

  private func registerNib() {
    tableView.register(cellType: ProductViewCell.self)
  }
}

private enum Constants {
  // Colors
  static let viewBackgroundColor = UIColor.Purple
  static let tableViewBackgroundColor = UIColor.Purple
  static let buttonTintColor = UIColor.Blue
  
  // Sizes
  static let tableViewEstimatedRowHeight: CGFloat = 150
}
