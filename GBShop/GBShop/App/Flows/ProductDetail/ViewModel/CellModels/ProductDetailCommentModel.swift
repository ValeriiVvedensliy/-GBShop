//
//  ProductDetailCommentModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ProductDetailCommentModel: ProductDetailCellModel {
  let count: Driver<String>
  let onTap: AnyObserver<Void>
}
