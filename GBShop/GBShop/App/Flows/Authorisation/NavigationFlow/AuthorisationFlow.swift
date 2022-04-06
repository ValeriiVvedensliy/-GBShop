//
//  AuthorisationFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import RxFlow
import UIKit

class AuthorisationFlow: Flow {
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
    case .authorisationRequired:
      return navigationToAuthorisationScreen()
      
    case .inputsFormRequired:
      return navigateToInputsForm()
      
    case .error(let text):
      return navigateToError(text: text)
      
    case .productsRequiredScreen:
      return navigationToProductsScreen()
      
    default:
      return .none
    }
  }

  private func navigationToAuthorisationScreen() -> FlowContributors {
    let viewModel = AuthorisationViewModel()

    let bundle = Bundle(for: AuthorisationTableViewController.self)
    let viewController = AuthorisationTableViewController(
      nibName: String(describing: AuthorisationTableViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
  
  private func navigationToProductsScreen() -> FlowContributors {
    return .one(flowContributor: .contribute(
      withNextPresentable: ProductsFlow(
        navigationController: self.navigationController
      ),
      withNextStepper: OneStepper(
        withSingleStep: AppStep.productsRequiredScreen
      ))
    )
  }
  
  private func navigateToInputsForm() -> FlowContributors {
    return .one(flowContributor: .contribute(
      withNextPresentable: InpuntsFormFlow(
        navigationController: self.navigationController,
        screenState: .create,
        user: UserVm(userId: nil, login: nil, password: nil, email: nil, gender: nil, creditCard: nil, bio: nil)
      ),
      withNextStepper: OneStepper(
        withSingleStep: AppStep.inputsFormRequired
      ))
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

