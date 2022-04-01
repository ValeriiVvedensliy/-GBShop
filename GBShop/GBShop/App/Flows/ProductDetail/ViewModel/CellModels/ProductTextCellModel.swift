//
//  ProductTextCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import Foundation
import RxCocoa

struct ProductTextCellModel: ProductDetailCellModel {
  let text: Driver<String>
}
