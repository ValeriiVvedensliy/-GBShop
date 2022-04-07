//
//  BaketFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 05.04.2022.
//

import Foundation
import RxFlow
import UIKit
import Firebase

class BasketFlow: Flow {
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
    case .basketScreenRequired:
      return navigationToBasketScreen()
      
    case .error(let text):
      return navigateToError(text: text)
      
    case .clouseScreen:
      return closeScreen()

    default:
      return .none
    }
  }

  private func navigationToBasketScreen() -> FlowContributors {
    let viewModel = BasketViewModel()

    let bundle = Bundle(for: BasketViewController.self)
    let viewController = BasketViewController(
      nibName: String(describing: BasketViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel
    self.navigationController.pushViewController(viewController, animated: true)

    Analytics.logEvent(AnalyticsEventScreenView, parameters: [
      "userId": String(describing: Basket.shared.userId),
      "productxId": String(describing: Basket.shared.getProductIds()),
      "message": "Show Basket"
    ])
    
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
  
  private func closeScreen() -> FlowContributors {
    navigationController.popViewController(animated: true)
    
    return .none
  }

}

