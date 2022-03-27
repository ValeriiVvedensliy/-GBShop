//
//  InputsFormValidationDelegate.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 26.03.2022.
//

import Foundation

class InputsFormValidationDelegate {
  func validate(_ value: String, _ type: ValidationFields) -> Bool {
    switch type {
    case .login:
      return value.count > 4
      
    case .password:
      return value.count > 6

    case .email:
      let emailPattern = #"^\S+@\S+\.\S+$"#
      let result = value.range(
          of: emailPattern,
          options: .regularExpression
      )
      return result != nil

    case .gender:
      return value.count > 0
      
    case .bio:
      return value.count < 20
      
    case .creditCard:
      let cardPattern = "^4[0-9]{6,}([0-9]{3})?$" // for VISA
      let result = value.range(
          of: cardPattern,
          options: .regularExpression
      )
      return result != nil
    }
  }
}
