//
//  DetailScreenNavigation.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 01.04.2022.
//

import Foundation
import RxFlow
import UIKit

class DetailScreenNavigation: Flow {
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
    case .detailProductScreenRequired(let product):
      return navigationToDetailScreen(product: product)
      
    case .commentsScreenRequired(let id):
      return navigateToCommetsScreen(productId: id)
      
    default:
      return .none
    }
  }

  private func navigationToDetailScreen(product: ProductDetailVisualModel) -> FlowContributors {
    let viewModel = ProductDetailViewModel(product: product)

    let bundle = Bundle(for: ProductDetailViewController.self)
    let viewController = ProductDetailViewController(
      nibName: String(describing: ProductDetailViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
  
  private func navigateToCommetsScreen(productId: String) -> FlowContributors {
    let flow = CommentsFlow(navigationController: navigationController)
    
    return .one(flowContributor: .contribute(
      withNextPresentable: flow,
      withNextStepper: OneStepper(withSingleStep: AppStep.commentsScreenRequired(productId: productId)))
    )
  }
}
