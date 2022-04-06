//
//  ProductDetailViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 31.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import RxFlow
import Reusable

class ProductDetailViewController: UITableViewController {
  lazy var dataSource = RxProductDetailDataSource()
  private let disposeBag = DisposeBag()
  public var viewModel: ProductDetailViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()

      registerNib()
      setUpView()
      setupBindings()
    }
  
  // MARK: - Bindings
  private func setupBindings() {
    viewModel?.source
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
  
  private func setUpView() {
    navigationController?.isNavigationBarHidden = false
    view.backgroundColor = Constants.viewBackgroundColor
    tableView.backgroundColor = Constants.tableViewBackgroundColor
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
    tableView.dataSource = nil
    tableView.delegate = nil
    setUpNavigationBarLeftButton()
  }
  
  private func setUpNavigationBarLeftButton() {
    let leftBtn = UIButton(frame: CGRect(x: 16, y: 28, width: 28, height: 28))
    leftBtn.tintColor = Constants.buttonTintColor
    let image = UIImage(
      named: IcNames.IcArrowBack,
      in: Bundle(for: InpuntsFormTableViewController.self),
      compatibleWith: nil)
    leftBtn.setImage(image, for: .normal)
    leftBtn.rx.tap
      .bind { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
      .disposed(by: disposeBag)

    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
  }

  private func registerNib() {
    tableView.register(cellType: ProductScreenViewCell.self)
    tableView.register(cellType: ProductTextViewCell.self)
    tableView.register(cellType: ProductCommentViewCell.self)
  }
}

private enum Constants {
  // Colors
  static let viewBackgroundColor = UIColor.Purple
  static let tableViewBackgroundColor = UIColor.Purple
  static let buttonTintColor = UIColor.White
  
  // Sizes
  static let tableViewEstimatedRowHeight: CGFloat = 500
}
