//
//  CommentViewCell.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import Kingfisher

class CommentViewCell: RxTableViewCell<CommentCellModel>, NibReusable {
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var commentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setUpView()
  }
  
  private func setUpView() {
    contentView.backgroundColor = Constants.contentViewBackgroundColor
    rootView.backgroundColor = Constants.rootViewBackgroundColor
    nameLabel.textColor = Constants.textColor
    dateLabel.textColor = Constants.textColor
    commentLabel.textColor = Constants.textColor
    nameLabel.font = Constants.nameFont
    dateLabel.font = Constants.dateFont
    commentLabel.font = Constants.commentFont
  }
  
  override func config(item: CommentCellModel) {
    dateLabel.text = item.date
    nameLabel.text = item.userName
    commentLabel.text = item.text
    let url = URL(string: item.photo)!
    userImage.kf.setImage(with: url)
  }
}

private enum Constants {
  // Colors
  static let contentViewBackgroundColor = UIColor.Purple
  static let rootViewBackgroundColor = UIColor.clear
  static let textColor = UIColor.White
  
  // Fonts
  static let dateFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
  static let nameFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
  static let commentFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
}
