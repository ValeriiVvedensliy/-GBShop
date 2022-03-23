//
//  String+Additions.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import UIKit

extension String {
  var localizationString: String {
    NSLocalizedString(
      self,
      tableName: nil,
      bundle: Bundle(for: AuthorisationFlow.self),
      value: "",
      comment: ""
    )
  }
  
  func leftAlignedAttributedString(
    foreground: UIColor
  ) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.lineSpacing = 22
    let font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
    let attributes = [
      NSAttributedString.Key.font: font,
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.foregroundColor: foreground
    ]
    return NSAttributedString(string: self, attributes: attributes)
  }

}
