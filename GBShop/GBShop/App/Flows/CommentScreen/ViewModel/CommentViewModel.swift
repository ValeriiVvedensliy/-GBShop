//
//  CommentViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow
import Alamofire

public final class CommentViewModel: RxViewModelProtocol, Stepper {
  struct Input {}

  struct Output {
    let source: Driver<[CommentSectionModel]>
  }

  private(set) var input: Input!
  private(set) var output: Output!
  private let disposeBag = DisposeBag()
  private var cellModels: [CommentCellModel] = []
  public let steps = PublishRelay<Step>()
  private var productId: String?
  
  private var service = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  
  // Output
  private let source = BehaviorSubject<[CommentSectionModel]>(value: [])

  public init(productId: String) {
    self.productId = productId
    input = Input()
    
    output = Output(
      source: source.asDriver(onErrorJustReturn: [])
    )
    
    bindComment()
  }

  private func bindComment() {
    guard let productId = productId else { return }
    service.getComments(productId: productId) {[weak self] response in
      switch response.result {
      case .success(let result):
        self?.setSource(response: result)
        
      case .failure(let error):
        self?.steps.accept(AppStep.error(text: error.localizedDescription))
      }
    }
  }
  
  private func setSource(response: CommentsResponse) {
    let comments = response.comments
    comments?.forEach { comment in
      cellModels.append(CommentCellModel(
        id: comment.id,
        userName: comment.userName,
        photo: comment.photo,
        date: comment.date,
        text: comment.text
      ))
    }
    
    let sectionCellModels = [
      CommentSectionModel(
        items: cellModels
      )
    ]
    
    source.onNext(sectionCellModels)
  }
}

