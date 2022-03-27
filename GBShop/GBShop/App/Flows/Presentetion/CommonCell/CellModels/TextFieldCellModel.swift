//
//  TextFieldCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

struct TextFieldCellModel: AuthorisationCellModel {
  let placeholder: String
  let onTextChanged: AnyObserver<String>
  let isDisabled: Driver<Bool>
}
