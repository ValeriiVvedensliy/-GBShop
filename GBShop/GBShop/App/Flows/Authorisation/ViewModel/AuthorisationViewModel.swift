//
//  AuthorisationViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

public final class AuthorisationViewModel: RxViewModelProtocol, Stepper {
  struct Input {
    let login: AnyObserver<String>
    let password: AnyObserver<String>
    let sendAction: PublishRelay<Void>
  }

  struct Output {
    let source: Observable<[AuthorisationSectionModel]>
    let validationResult: Driver<Bool>
    let isInValidWhileSending: PublishRelay<Bool>
  }

  private(set) var input: Input!
  private(set) var output: Output!
  private let disposeBag = DisposeBag()
  public let steps = PublishRelay<Step>()

  // Input
  private let login = BehaviorSubject<String>(value: "")
  private let password = BehaviorSubject<String>(value: "")
  private let sendAction = PublishRelay<Void>()
  private let registrationAction = PublishRelay<Void>()
  
  // Output
  private let validationResult = BehaviorSubject<Bool>(value: false)
  private let sendingStateEnabled = BehaviorSubject<Bool>(value: false)
  private let buttonIsEnabled = BehaviorSubject<Bool>(value: false)
  private let validationLabelIsHidden = BehaviorSubject<Bool>(value: true)
  private let isInValidWhileSending = PublishRelay<Bool>()
  let service = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  
  private lazy var source: Observable<[AuthorisationSectionModel]> = {
    Observable.of([
      AuthorisationSectionModel(
        items: [
          TitleCellModel(
            title: Constants.titleCellModelTitle
          ),
          TextFieldCellModel(
            placeholder: Constants.loginTextFieldPlaceholder,
            onTextChanged: input.login,
            isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
          ),
          TextFieldCellModel(
            placeholder: Constants.passwordTextFieldPlaceholder,
            onTextChanged: input.password,
            isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
          ),
          ButtonCellModel(
            title: Constants.lodInLabelText,
            actionTitle: Constants.logIningLabelText,
            isEnabled: buttonIsEnabled.asDriver(onErrorJustReturn: false),
            isSending: sendingStateEnabled.asDriver(onErrorJustReturn: false),
            onTap: input.sendAction
          ),
          TextButtonCellModel(
            title: Constants.registrationButtonText,
            isSending: sendingStateEnabled.asDriver(onErrorJustReturn: false),
            onTap: registrationAction
          ),
          ValidationCellModel(isHidden: validationLabelIsHidden.asDriver(onErrorJustReturn: true))
        ]
      )
    ])
  }()

  public init() {
    input = Input(
      login: login.asObserver(),
      password: password.asObserver(),
      sendAction: sendAction
    )
    output = Output(
      source: source,
      validationResult: validationResult.asDriver(onErrorJustReturn: false),
      isInValidWhileSending: isInValidWhileSending
    )
    
    setupBinding()
  }
  private func setupBinding() {
    bindValidationResult()
    bindSending()
    bindValidationLabelIsHidden()
    bindButtonIsEnabled()
    bindRegistrationButton()
  }

  private func bindButtonIsEnabled() {
    Observable
      .combineLatest(login, password)
      .map {
        !$0.isEmpty && !$1.isEmpty
      }
      .bind(to: buttonIsEnabled)
      .disposed(by: disposeBag)
  }

  private func bindValidationLabelIsHidden() {
    sendAction
      .withLatestFrom(validationResult)
      .bind(to: validationLabelIsHidden)
      .disposed(by: disposeBag)
  }

  private func bindValidationResult() {
    Observable.combineLatest(login, password)
      .map { [weak self] login, password in
        guard let self = self else { return false }

        return self.areFieldsValid(login: login, password: password)
      }
      .bind(to: validationResult)
      .disposed(by: disposeBag)
  }
  
  private func bindRegistrationButton() {
    registrationAction
      .map { _ in
        return AppStep.inputsFormRequired }
      .bind(to: steps)
      .disposed(by: disposeBag)
  }

  private func bindSending() {
    sendAction
      .withLatestFrom(
        Observable.combineLatest(login, password, validationResult)
      )
      .filter { _, _, validationResult in
        validationResult
      }
      .bind { [weak self] login, password, validationResult in
        guard let self = self else { return }

        self.isInValidWhileSending.accept(validationResult)
        self.sendingStateEnabled.onNext(true)
        
        self.service.login(
          login: login,
          password: password
        ) { response in
          self.sendingStateEnabled.onNext(false)
          switch response.result {
          case .success(let result):
            self.steps.accept(AppStep.productsScreenRequired)
            print("\(result) \n")
          case .failure(let error):
            self.steps.accept(AppStep.error(text: error.localizedDescription))
          }
        }
      }
      .disposed(by: disposeBag)
  }

  private func areFieldsValid(login: String, password: String) -> Bool {
    login.count > 4 && password.count > 6
  }
}

private enum Constants {
  // Strings
  static let logIningLabelText = "ButtonViewCell.LogIning.Label.Text".localizationString
  static let lodInLabelText = "ButtonViewCell.Label.Text".localizationString
  static let registrationButtonText = "TextButtonViewCell.Title.Text".localizationString
  static let titleCellModelTitle = "AuthorisationTableViewController.TitleCellModel.Title"
  static let loginTextFieldPlaceholder = "AuthorisationTableViewController.LoginTextField.Placeholder"
  static let passwordTextFieldPlaceholder = "AuthorisationTableViewController.PasswordTextField.Placeholder"
}
