//
//  ProductViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import UIKit
import Reusable
import Kingfisher
import RxCocoa

class ProductViewCell: RxTableViewCell<ProductsCellModel>, NibReusable {
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpView()
  }
  
  private func setUpView() {
    contentView.backgroundColor = Constants.contentColor
    nameLabel.font = Constants.fontHeader
    nameLabel.textColor = Constants.textColor
    priceLabel.font = Constants.fontHeader
    priceLabel.textColor = Constants.textColor
    addButton.tintColor = Constants.buttonColor
  }

  override func config(item: ProductsCellModel) {
    nameLabel.text = item.name
    priceLabel.text = "$\(item.price)"
    guard let url = URL(string: item.image) else { return }
    productImageView.kf.setImage(with: url)
    addButton.isHidden = item.isHiddenButton

    addButton.rx.tap
      .map { _ in item.index }
      .bind(to: item.buttonTap)
      .disposed(by: disposeBag)
  }
}

private enum Constants {
  // Coolors
  static let textColor = UIColor.White
  static let contentColor = UIColor.Purple
  static let buttonColor = UIColor.Blue
  
  // Fonts
  static let fontHeader = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
  static let fontBody = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
}
