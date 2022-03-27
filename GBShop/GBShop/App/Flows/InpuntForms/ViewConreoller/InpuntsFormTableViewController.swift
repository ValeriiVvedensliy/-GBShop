//
//  InpuntsFormTableViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 24.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import RxFlow
import Reusable

class InpuntsFormTableViewController: UITableViewController {
  lazy var dataSource = RxInpuntsFormDataSource()
  private let disposeBag = DisposeBag()
  public var viewModel: InputsFormViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    registerNib()
    setUpView()
    setupBindings()
  }
  
  // MARK: - Bindings
  private func setupBindings() {
    viewModel?.output.source
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
    tableView.keyboardDismissMode = .interactive
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
      .bind { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      }
      .disposed(by: disposeBag)

    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
  }
  
  private func registerNib() {
    tableView.register(cellType: TitleTableViewCell.self)
    tableView.register(cellType: TextFieldTableViewCell.self)
    tableView.register(cellType: ButtonTableViewCell.self)
    tableView.register(cellType: ValidationTableViewCell.self)
  }
}

private enum Constants {
  // Colors
  static let viewBackgroundColor = UIColor.Grey
  static let tableViewBackgroundColor = UIColor.Grey
  static let buttonTintColor = UIColor.Blue
  
  // Sizes
  static let tableViewEstimatedRowHeight: CGFloat = 48
}
