//
//  TextButtonTableViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 23.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class TextButtonTableViewCell: RxTableViewCell<TextButtonCellModel>, NibReusable {
  
  @IBOutlet weak var button: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpView()
  }
  
  override func config(item: TextButtonCellModel) {
    item.isSending
      .filter { $0 }
      .map { _ in false }
      .drive(button.rx.isEnabled)
      .disposed(by: disposeBag)
    
    item.isSending
      .filter { !$0 }
      .map { _ in true }
      .drive(button.rx.isEnabled)
      .disposed(by: disposeBag)
    
    button.rx.tap
      .map { _ in Void() }
      .bind(to: item.onTap)
      .disposed(by: disposeBag)
    
    button.setTitle(item.title, for: .normal)
    button.tintColor = Constants.buttonTintColor
  }
  
  private func setUpView() {
    contentView.backgroundColor = Constants.contentViewBackgroundColor
  }
}

private enum Constants {
  // Color
  static let contentViewBackgroundColor = UIColor.Purple
  static let buttonTintColor = UIColor.Blue
}
