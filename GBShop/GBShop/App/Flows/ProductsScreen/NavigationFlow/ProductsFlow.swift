//
//  ProductsFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 28.03.2022.
//

import Foundation
import RxFlow
import UIKit
import Firebase

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
    case .productsScreenRequired:
      return navigationToProductScreen()
      
    case .detailProductScreenRequired(let product):
      return navigateToDetailScreen(product: product)
      
    case .basketScreenRequired:
      return navigateToBasketScreen()
      
    case .showToast:
      return showToast()
      
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
    self.navigationController.pushViewController(viewController, animated: true)

    Analytics.logEvent(AnalyticsEventScreenView, parameters: [
      "userId": String(describing: Basket.shared.userId),
      "message": "Show Products Screen"
    ])
    
    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
  
  private func showToast() -> FlowContributors {
    guard let controller = navigationController.viewControllers.last else { return .none }
    
    controller.showToast(message: "Product move to basket", font: .systemFont(ofSize: 17))
    
    return .none
  }
  
  private func navigateToBasketScreen() -> FlowContributors {
    let flow = BasketFlow(navigationController: navigationController)
    
    return .one(flowContributor: .contribute(
      withNextPresentable: flow,
      withNextStepper: OneStepper(withSingleStep: AppStep.basketScreenRequired))
    )
  }
  
  private func navigateToDetailScreen(product: ProductDetailVisualModel) -> FlowContributors {
    let flow = DetailScreenNavigation(navigationController: navigationController)
    
    return .one(flowContributor: .contribute(
      withNextPresentable: flow,
      withNextStepper: OneStepper(withSingleStep: AppStep.detailProductScreenRequired(product: product)))
    )
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

