//
//  CommentViewController.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator
import RxFlow
import Reusable

class CommentViewController: UITableViewController {
  lazy var dataSource = RxCommentsDataSource()
  private let disposeBag = DisposeBag()
  public var viewModel: CommentViewModel!
  
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
    setUpNavigationBarLeftButton()
    setUpNavigationBarTitle()
    view.backgroundColor = Constants.viewBackgroundColor
    tableView.backgroundColor = Constants.tableViewBackgroundColor
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = .White
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = Constants.tableViewEstimatedRowHeight
    tableView.keyboardDismissMode = .interactive
    tableView.dataSource = nil
    tableView.delegate = nil
  }
  
  private func setUpNavigationBarTitle() {
    let titleLabel = UILabel()
    titleLabel.attributedText = "Comments".aligmentAttributedString(
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

  private func registerNib() {
    tableView.register(cellType: CommentViewCell.self)
  }
  
}

private enum Constants {
  // Colors
  static let viewBackgroundColor = UIColor.Purple
  static let tableViewBackgroundColor = UIColor.Purple
  static let buttonTintColor = UIColor.White
  
  // Sizes
  static let tableViewEstimatedRowHeight: CGFloat = 150
}
