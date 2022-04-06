//
//  CommentsFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 02.04.2022.
//

import Foundation
import RxFlow
import UIKit

class CommentsFlow: Flow {
  var navigationController: UINavigationController

  var root: Presentable {
    self.navigationController
  }

  init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }

  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? AppStep else { return .none }

    switch step {
    case .commentsScreenRequired(let id):
      return navigationToCommentsScreen(id: id)
      
    default:
      return .none
    }
  }

  private func navigationToCommentsScreen(id: String) -> FlowContributors {
    let viewModel = CommentViewModel(productId: id)

    let bundle = Bundle(for: CommentViewController.self)
    let viewController = CommentViewController(
      nibName: String(describing: CommentViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
}
