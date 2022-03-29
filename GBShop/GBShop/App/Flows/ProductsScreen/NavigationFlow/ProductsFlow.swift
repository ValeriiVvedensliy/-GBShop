//
//  ProductsFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 28.03.2022.
//

import Foundation
import RxFlow
import UIKit

class ProductsFlow: Flow {
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
    case .productsRequiredScreen:
      return navigationToProductScreen()
      
    case .error(let text):
      return navigateToError(text: text)
      
    default:
      return .none
    }
  }

  private func navigationToProductScreen() -> FlowContributors {
    let viewModel = ProductsViewModel()

    let bundle = Bundle(for: ProductsTableViewController.self)
    let viewController = ProductsTableViewController(
      nibName: String(describing: ProductsTableViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel
    viewController.modalPresentationStyle = .overFullScreen
    viewController.modalTransitionStyle = .crossDissolve

    self.navigationController.present(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
  
  private func navigateToError(text: String) -> FlowContributors {
    guard let controller = navigationController.viewControllers.last else {
      return .none
    }
    
    let flow = ErrorFlow(viewController: controller)
    return .one(flowContributor: .contribute(
      withNextPresentable: flow,
      withNextStepper: OneStepper(withSingleStep: AppStep.error(text: text)))
    )
  }
}

