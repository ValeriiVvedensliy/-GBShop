//
//  ProductsViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 29.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow
import Alamofire

public final class ProductsViewModel: RxViewModelProtocol, Stepper {
  struct Input {
    let onSelectedCell: AnyObserver<IndexPath>
  }

  struct Output {
    let source: Driver<[ProductsSectionModel]>
  }

  private(set) var input: Input!
  private(set) var output: Output!
  private let disposeBag = DisposeBag()
  public let steps = PublishRelay<Step>()
  
  private var service = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  
  // Output
  let indexOfSelectedCell = PublishSubject<IndexPath>()
  private let source = BehaviorSubject<[ProductsSectionModel]>(value: [])

  public init() {
    input = Input(
      onSelectedCell: indexOfSelectedCell.asObserver()
    )
    
    output = Output(
      source: source.asDriver(onErrorJustReturn: [])
    )
    
    bindProducts()
  }
  
  private func bindProducts() {
    service.getProducts() {[weak self] response in
      switch response.result {
      case .success(let result):
        self?.setSource(response: result)
        
      case .failure(let error):
        self?.steps.accept(AppStep.error(text: error.localizedDescription))
      }
    }
  }
  
  private func setSource(response: ProductsResponse) {
    let products = response.products
    var cellModels: [ProductsCellModel] = []
    products?.forEach { product in
      cellModels.append(ProductsCellModel(
        name: product.name,
        price: product.price,
        description: product.description,
        image: product.url
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
