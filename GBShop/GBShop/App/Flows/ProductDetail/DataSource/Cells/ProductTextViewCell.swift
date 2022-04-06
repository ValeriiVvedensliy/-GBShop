//
//  ProductTextViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Kingfisher

class ProductTextViewCell:  RxTableViewCell<ProductTextCellModel>, NibReusable  {
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var topSeparateView: UIView!
  @IBOutlet weak var bottomSeparateView: UIView!
  @IBOutlet weak var textInfo: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()

      setUpView()
    }
  
  private func setUpView() {
    rootView.backgroundColor = Constants.rootViewBackgroundColor
    topSeparateView.backgroundColor = Constants.separateViewColor
    bottomSeparateView.backgroundColor = Constants.separateViewColor
    contentView.backgroundColor = Constants.contentViewBackgroundColor
  }
    
  override func config(item: ProductTextCellModel) {
    item.text
      .drive { [weak self] text in
        self?.textInfo.attributedText = text.aligmentAttributedString(
          foreground: Constants.labelTextColor,
          aligment: .left,
          sketchLineHeight: Constants.textSketchLineHeight,
          fontSize: Constants.textFontSize
        )
      }
      .disposed(by: disposeBag)
  }
}

private enum Constants {
  // Colors
  static let contentViewBackgroundColor = UIColor.Purple
  static let rootViewBackgroundColor = UIColor.clear
  static let separateViewColor = UIColor.White
  static let labelTextColor = UIColor.White
  
  // Numbers
  static let textSketchLineHeight: CGFloat = 22
  static let textFontSize: CGFloat = 19
}
