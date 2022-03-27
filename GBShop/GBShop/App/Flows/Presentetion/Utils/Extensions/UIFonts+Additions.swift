//
//  UIFonts+Additions.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 27.03.2022.
//

import Foundation
import UIKit

extension UIFont {
  func lineSpacing(sketchLineHeight: CGFloat) -> CGFloat {
    sketchLineHeight - lineHeight
  }
}
