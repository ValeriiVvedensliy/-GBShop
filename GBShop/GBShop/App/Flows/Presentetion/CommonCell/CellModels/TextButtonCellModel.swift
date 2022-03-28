//
//  TextButtonCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 23.03.2022.
//

import Foundation
import RxCocoa

struct TextButtonCellModel: AuthorisationCellModel {
  let title: String
  let isSending: Driver<Bool>
  let onTap: PublishRelay<Void>
}
