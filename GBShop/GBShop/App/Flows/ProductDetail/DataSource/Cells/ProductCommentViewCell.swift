//
//  ProductCommentViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 31.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Kingfisher

class ProductCommentViewCell: RxTableViewCell<ProductDetailCommentModel>, NibReusable {
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var bottomSeparateView: UIView!
  @IBOutlet weak var buttonImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  private let tapGesture = UITapGestureRecognizer()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpView()
  }
  
  private func setUpView() {
    setView()
    setImageView()
    setUpLabel()
  }
  
  private func setView() {
    rootView.backgroundColor = Constants.rootViewBackgroundColor
    contentView.backgroundColor = Constants.contentViewBackgroundColor
    bottomSeparateView.backgroundColor = Constants.separateViewColor
  }
  
  private func setImageView() {
    buttonImageView.image = UIImage(
      named: IcNames.IcArrowRight,
      in: Bundle(for: ProductCommentViewCell.self),
      compatibleWith: nil)
    buttonImageView.tintColor = Constants.imageTintColor
    buttonImageView.addGestureRecognizer(tapGesture)
  }
  
  private func setUpLabel() {
    titleLabel.attributedText = Constants.textCell.aligmentAttributedString(
      foreground: Constants.textColor,
      aligment: .left,
      sketchLineHeight: Constants.textSketchLineHeight,
      fontSize: Constants.textFontSize
    )
  }
  
  override func config(item: ProductDetailCommentModel) {
    item.count
      .drive { [weak self] count in
        self?.countLabel.attributedText = "\(count)".aligmentAttributedString(
          foreground: Constants.labelTextColor,
          aligment: .left,
          sketchLineHeight: Constants.textSketchLineHeight,
          fontSize: Constants.textFontSize
        )
      }
      .disposed(by: disposeBag)
    
    tapGesture.rx.event
      .map { _ in Void() }
      .bind(to: item.onTap)
      .disposed(by: disposeBag)
  }
}

private enum Constants {
  // Colors
  static let contentViewBackgroundColor = UIColor.Purple
  static let rootViewBackgroundColor = UIColor.clear
  static let separateViewColor = UIColor.White
  static let labelTextColor = UIColor.White
  static let imageTintColor = UIColor.White
  static let textColor = UIColor.White
  
  // Numbers
  static let textSketchLineHeight: CGFloat = 22
  static let textFontSize: CGFloat = 17
  
  // Strings
  static let textCell = "Detail.CommentsCell.Text".localizationString
}
