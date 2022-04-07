//
//  BasketViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import RxFlow
import Reusable

class BasketViewController: UITableViewController {
  lazy var dataSource = RxProductsDataSource()
  private let disposeBag = DisposeBag()
  public var viewModel: BasketViewModel!
  
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
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton())
    setUpNavigationBarTitle()
    setUpNavigationBarRightButton()
    setUpNavigationBarLeftButton()
    view.backgroundColor = Constants.viewBackgroundColor
    tableView.backgroundColor = Constants.tableViewBackgroundColor
    tableView.separatorStyle = .none
    tableView.separatorColor = .White
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
    tableView.keyboardDismissMode = .interactive
    tableView.dataSource = nil
    tableView.delegate = nil
  }
  
  private func setUpNavigationBarTitle() {
    let titleLabel = UILabel()
    titleLabel.attributedText = "Basket".aligmentAttributedString(
      foreground: .White,
      aligment: .center,
      sketchLineHeight: 22,
      fontSize: 19
    );
    
    navigationItem.titleView = titleLabel
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
  
  private func setUpNavigationBarRightButton() {
    let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 58, height: 32))
    rightBtn.backgroundColor = Constants.buttonTintColor
    rightBtn.layer.cornerRadius = rightBtn.frame.height / 2
    rightBtn.setTitle("Buy", for: .normal)
    rightBtn.setTitleColor(.white, for: .normal)
    rightBtn.rx.tap
      .bind(to: viewModel.input.onSendingAction)
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
