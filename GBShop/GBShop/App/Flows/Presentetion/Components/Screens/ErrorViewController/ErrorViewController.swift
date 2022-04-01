import UIKit
import RxFlow
import RxRelay

class ErrorViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  var messageText: String

  @IBOutlet private var mainStackView: UIStackView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var messageLabel: UILabel!
  @IBOutlet private var confirmButton: UIButton!

  init(
    with errorText: String
  ) {
  
    self.messageText = errorText
    super.init(nibName: Constants.nibName, bundle: Bundle(for: ErrorViewController.self))
  }

  required init?(coder aDecoder: NSCoder) {
    messageText = Constants.emptyText
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupMainView()
    setupMainStack()
    setupTitleLabel()
    setupMessageLabel()
    setupConfirmButton()
  }

  @IBAction private func onConfirmButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }

  private func setupMainView() {
    view.backgroundColor = Constants.mainViewBackgroundColor
  }

  private func setupMainStack() {
    mainStackView.backgroundColor = Constants.mainStackBackgroundColor
    mainStackView.layer.cornerRadius = Constants.mainStackLayerCornerRadius
  }

  private func setupConfirmButton() {
    confirmButton.setTitle(Constants.errorButtonText, for: .normal)
    confirmButton.backgroundColor = Constants.confirmButtonBackgroundColor
    confirmButton.setTitleColor(Constants.confirmButtonTitleColor, for: .normal)
    confirmButton.layer.cornerRadius = Constants.confirmButtonLayerCornerRadius
  }

  private func setupTitleLabel() {
    titleLabel.attributedText = Constants.errorTitleText.aligmentAttributedString(
      foreground: Constants.titleLabelForegroundColor,
      aligment: .center,
      sketchLineHeight: Constants.titleLabelSketchLineHeight,
      fontSize: 19
    )
  }

  private func setupMessageLabel() {
    messageLabel.attributedText = messageText.aligmentAttributedString(
      foreground: Constants.messageLabelForeground,
      aligment: .center,
      sketchLineHeight: Constants.messageLineSketchLineHeight,
      fontSize: 17
    )
  }
}

private enum Constants {
  // Strings
  static let nibName = String(describing: ErrorViewController.self)
  static let emptyText = ""
  static let errorTitleText = "ErrorViewController.Title.Text".localizationString
  static let errorButtonText = "ErrorViewController.Button.Text".localizationString

  // Colors
  static let mainViewBackgroundColor = UIColor.black.withAlphaComponent(0.4)
  static let mainStackBackgroundColor = UIColor.Purple
  static let confirmButtonBackgroundColor = UIColor.Blue
  static let confirmButtonTitleColor = UIColor.White
  static let titleLabelForegroundColor = UIColor.White
  static let messageLabelForeground = UIColor.White

  // Sizes
  static let mainStackLayerCornerRadius: CGFloat = 16
  static let confirmButtonLayerCornerRadius: CGFloat = 24
  static let messageLineSketchLineHeight: CGFloat = 20
  static let titleLabelSketchLineHeight: CGFloat = 22
}
