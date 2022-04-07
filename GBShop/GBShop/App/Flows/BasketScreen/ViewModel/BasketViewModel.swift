//
//  BaketViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow
import Alamofire

public final class BasketViewModel: RxViewModelProtocol, Stepper {
  struct Input {
    let onSendingAction: AnyObserver<Void>
  }

  struct Output {
    let source: Driver<[ProductsSectionModel]>
  }

  private(set) var input: Input!
  private(set) var output: Output!
  private let disposeBag = DisposeBag()
  private var cellModels: [ProductsCellModel] = []
  public let steps = PublishRelay<Step>()
  
  private var service = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  private var basket = Basket.shared
  
  // Input
  private let sendingAction = PublishSubject<Void>()
  
  // Output
  let indexOfSelectedCell = PublishSubject<IndexPath>()
  private let source = BehaviorSubject<[ProductsSectionModel]>(value: [])

  public init() {
    input = Input(
      onSendingAction: sendingAction.asObserver()
    )
    
    output = Output(
      source: source.asDriver(onErrorJustReturn: [])
    )
    
    bindProducts()
    bindBuyProducts()
  }
  
  private func bindBuyProducts() {
    sendingAction
      .bind { [weak self] in
        guard let self = self else { return }
        
        self.service.payBasket(userId: self.basket.userId) { response in
          switch response.result {
          case .success(_):
            self.basket.defaultState()
            self.steps.accept(AppStep.clouseScreen)
            
          case .failure(let error):
            self.steps.accept(AppStep.error(text: error.localizedDescription))
          }
        }
      }
      .disposed(by: disposeBag)
  }
  
  private func bindProducts() {
    guard let products = basket.getProduct() else { return }
    
    for (index, product) in products.enumerated() {
      cellModels.append(ProductsCellModel(
        id: product.id,
        name: product.name,
        price: product.price,
        description: product.description,
        image: product.url,
        isHiddenButton: true,
        buttonTap: PublishRelay<Int>(),
        index: index
      ))
    }
    
    let sectionCellModels = [
      ProductsSectionModel(
        items: cellModels
      )
    ]
    
    source.onNext(sectionCellModels)
  }
}
