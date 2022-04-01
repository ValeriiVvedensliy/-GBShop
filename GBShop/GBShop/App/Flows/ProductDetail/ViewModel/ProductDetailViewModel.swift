//
//  ProductDetailViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 30.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow
import Alamofire

class ProductDetailViewModel: RxViewModelProtocol, Stepper {
  struct Input {
    let onGoToCommentsScreenAction: AnyObserver<Void>
  }

  struct Output {
    let image: Driver<String>
    let name: Driver<String>
    let price: Driver<String>
    let description: Driver<String>
    let commentsCount: Driver<String>
  }

  private(set) var input: Input!
  private(set) var output: Output!
  private let disposeBag = DisposeBag()
  public let steps = PublishRelay<Step>()
  
  public var product: ProductDetailVisualModel?
  private var service = AppDelegate.container.resolve(AbstractRequestFactory.self)!

  // Input
  let onGoToCommentsScreenAction = PublishSubject<Void>()
  
  // Output
  private let image: BehaviorSubject<String>
  private let name: BehaviorSubject<String>
  private let price: BehaviorSubject<String>
  private let description: BehaviorSubject<String>
  private let commentsCount: BehaviorSubject<String>
  
  var source: Observable<[ProductDetailSectionModel]>!
  
  private lazy var cellModells: [ProductDetailCellModel] = [
          ProductImageCellModel(image: output.image),
          ProductTextCellModel(text: output.name),
          ProductTextCellModel(text: output.price),
          ProductTextCellModel(text: output.description),
          ProductDetailCommentModel(
            count: output.commentsCount,
            onTap: input.onGoToCommentsScreenAction.asObserver()
          )
        ]
  
  public init(product: ProductDetailVisualModel) {
    self.product = product

    image = BehaviorSubject<String>(value: product.image ?? "")
    name = BehaviorSubject<String>(value: product.name ?? "")
    price = BehaviorSubject<String>(value: "\(product.price ?? 0)")
    description = BehaviorSubject<String>(value: product.description ?? "")
    commentsCount = BehaviorSubject<String>(value: product.countComments ?? "")
    
    input = Input(
      onGoToCommentsScreenAction: onGoToCommentsScreenAction.asObserver()
    )
    output = Output(
      image: image.asDriver(onErrorJustReturn: ""),
      name: name.asDriver(onErrorJustReturn: ""),
      price: price.asDriver(onErrorJustReturn: ""),
      description: description.asDriver(onErrorJustReturn: ""),
      commentsCount: commentsCount.asDriver(onErrorJustReturn: "")
    )
    
    source = Observable.of([ProductDetailSectionModel(items: cellModells)])
    setupBinding()
  }
  
  private func setupBinding() {
    
  }
}
