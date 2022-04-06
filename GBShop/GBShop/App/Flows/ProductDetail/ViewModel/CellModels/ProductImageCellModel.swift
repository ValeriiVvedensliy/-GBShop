//
//  ProductImageCellModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import Foundation
import RxCocoa

struct ProductImageCellModel: ProductDetailCellModel {
  let image: Driver<String>
}
