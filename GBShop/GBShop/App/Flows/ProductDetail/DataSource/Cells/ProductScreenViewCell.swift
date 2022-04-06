//
//  ProductImageViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Kingfisher

class ProductScreenViewCell: RxTableViewCell<ProductImageCellModel>, NibReusable {
  
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var productImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  private func setUpView() {
    rootView.backgroundColor = Constants.rootViewBackgroundColor
    contentView.backgroundColor = Constants.contentViewBackgroundColor
  }
  
  override func config(item: ProductImageCellModel) {
    item.image
      .drive { [weak self] url in
        guard let url = URL(string: url) else { return }
        
        self?.productImageView.kf.setImage(with: url)
      }
      .disposed(by: disposeBag)
  }
}

private enum Constants {
  // Colors
  static let contentViewBackgroundColor = UIColor.Purple
  static let rootViewBackgroundColor = UIColor.clear
  
  // Fonts
  static let fontHeader = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
  static let fontBody = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
}
