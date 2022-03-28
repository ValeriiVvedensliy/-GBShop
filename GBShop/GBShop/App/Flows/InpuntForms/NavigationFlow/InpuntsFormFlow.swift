//
//  InpuntsFormFlow.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 24.03.2022.
//

import Foundation
import RxFlow
import UIKit

class InpuntsFormFlow: Flow {
  var navigationController: UINavigationController
  var screenState: InputsScreenState
  var user: UserVm

  var root: Presentable {
    self.navigationController
  }

  init(
    navigationController: UINavigationController,
    screenState: InputsScreenState,
    user: UserVm
  ) {
    self.navigationController = navigationController
    self.screenState = screenState
    self.user = user
  }

  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? AppStep else { return .none }

    switch step {
    case .inputsFormRequired:
      return navigationToInputsScreen(screenState: screenState, user: user)
      
    default:
      return .none
    }
  }

  private func navigationToInputsScreen(screenState: InputsScreenState, user: UserVm) -> FlowContributors {
    let viewModel = InputsFormViewModel(user: user, screenState: screenState)

    let bundle = Bundle(for: InpuntsFormTableViewController.self)
    let viewController = InpuntsFormTableViewController(
      nibName: String(describing: InpuntsFormTableViewController.self),
      bundle: bundle
    )
    viewController.viewModel = viewModel

    self.navigationController.pushViewController(viewController, animated: true)

    return .one(flowContributor: .contribute(
      withNextPresentable: viewController,
      withNextStepper: viewModel))
  }
}
