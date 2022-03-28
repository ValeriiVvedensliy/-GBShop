//
//  ValidationCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import RxCocoa

struct ValidationCellModel: AuthorisationCellModel {
  let result = "ValidationCellModel.Text"
  let isHidden: Driver<Bool>
}
