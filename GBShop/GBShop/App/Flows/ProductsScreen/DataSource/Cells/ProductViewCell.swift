//
//  ProductViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import UIKit
import Reusable
import Kingfisher

class ProductViewCell: UITableViewCell, NibReusable {
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
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
  }
  
  func config(model: ProductsCellModel) {
    nameLabel.text = model.name
    priceLabel.text = "$\(model.price)"
    guard let url = URL(string: model.image) else { return }
    productImageView.kf.setImage(with: url)
  }
}

private enum Constants {
  // Coolors
  static let textColor = UIColor.White
  static let contentColor = UIColor.Purple
  
  // Fonts
  static let fontHeader = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
  static let fontBody = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
}
