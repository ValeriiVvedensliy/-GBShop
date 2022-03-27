import Foundation
import RxFlow
import UIKit

class ErrorFlow: Flow {
  var viewController: UIViewController

  var root: Presentable {
    self.viewController
  }

  init(
    viewController: UIViewController,
    parentsFlowStep: AppStep? = nil
  ) {
    self.viewController = viewController
  }

  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? AppStep else { return .none }

    switch step {
    case .error(let text):
      return navigateToError(error: text)

    default:
      return .none
    }
  }

  private func navigateToError(error: String) -> FlowContributors {
    let errorVc = ErrorViewController(with: error)
    present(errorVc)

    return .one(flowContributor: .contribute(
      withNextPresentable: errorVc,
      withNextStepper: errorVc)
    )
  }

  private func present(
    _ viewController: UIViewController
  ) {
    viewController.modalPresentationStyle = .overFullScreen
    viewController.modalTransitionStyle = .crossDissolve
    self.viewController.present(viewController, animated: false)
  }
}
