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
  private var cellModels: [ProductsCellModel] = []
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
    bindsSelected()
  }
  
  private func bindsSelected() {
    indexOfSelectedCell
      .bind { [weak self] index in
        self?.service.getComments(productId: "\(String(describing: self?.cellModels[index.item].id))") { response in
          switch response.result {
          case .success(let result):
            let model = result as CommentsResponse
            let count = "\(model.comments?.count ?? 0)"
            self?.steps.accept(AppStep.detailProductScreenRequired(product: ProductDetailVisualModel(
              id: self?.cellModels[index.item].id,
              name: self?.cellModels[index.item].name,
              price: self?.cellModels[index.item].price,
              description: self?.cellModels[index.item].description,
              image: self?.cellModels[index.item].image,
              countComments: count
            )))
            break
            
          default:
            break
          }
        }
      }
      .disposed(by: disposeBag)
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
    products?.forEach { product in
      cellModels.append(ProductsCellModel(
        id: product.id,
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
