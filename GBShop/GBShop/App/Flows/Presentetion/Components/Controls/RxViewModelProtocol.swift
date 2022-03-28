//
//  RxViewModelProtocol.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation

protocol RxViewModelProtocol {
  associatedtype Input
  associatedtype Output

  var input: Input! { get }
  var output: Output! { get }
}
