//
//  ValidationTableViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class ValidationTableViewCell: RxTableViewCell<ValidationCellModel>, NibReusable {
  @IBOutlet private var label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpCell()
  }
  
  override func config(item: ValidationCellModel) {
    label.text = item.result.localizationString
    
    item.isHidden
      .drive(label.rx.isHidden)
      .disposed(by: disposeBag)
  }
  
  private func setUpCell() {
    contentView.backgroundColor = Constants.contentViewBackgroundColor
    label.textColor = Constants.labelTextColor
  }
}

private enum Constants {
  // Colors
  static let labelTextColor = UIColor.Red
  static let contentViewBackgroundColor = UIColor.Purple
}
