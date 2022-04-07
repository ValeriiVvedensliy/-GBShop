//
//  InputsFormViewModel.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 24.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow
import Alamofire
import Firebase

public enum InputsScreenState {
  case create
  case edit
}

public final class InputsFormViewModel: RxViewModelProtocol, Stepper {
  struct Input {
    let login: AnyObserver<String>
    let password: AnyObserver<String>
    let email: AnyObserver<String>
    let gender: AnyObserver<String>
    let creditCard: AnyObserver<String>
    let bio: AnyObserver<String>
    let sendAction: PublishRelay<Void>
    let onExitScreenAction: AnyObserver<Void>
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
  public var screenState: InputsScreenState
  public var user: UserVm
  private var service = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  private let validateDelegate = InputsFormValidationDelegate()

  // Input
  private let login: BehaviorSubject<String>
  private let password: BehaviorSubject<String>
  private let gender: BehaviorSubject<String>
  private let email: BehaviorSubject<String>
  private let bio: BehaviorSubject<String>
  private let creditCard: BehaviorSubject<String>
  private let sendAction = PublishRelay<Void>()
  let exitScreen = PublishSubject<Void>()
  
  // Output
  private let validationResult = BehaviorSubject<Bool>(value: false)
  private let sendingStateEnabled = BehaviorSubject<Bool>(value: false)
  private let buttonIsEnabled = BehaviorSubject<Bool>(value: false)
  private let validationLabelIsHidden = BehaviorSubject<Bool>(value: true)
  private let isInValidWhileSending = PublishRelay<Bool>()
  
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
          TextFieldCellModel(
            placeholder: Constants.emailTextFieldPlaceholder,
            onTextChanged: input.email,
            isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
            ),
            TextFieldCellModel(
              placeholder: Constants.genderTextFieldPlaceholder,
              onTextChanged: input.gender,
              isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
              ),
          TextFieldCellModel(
            placeholder: Constants.creditCardTextFieldPlaceholder,
            onTextChanged: input.creditCard,
            isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
            ),
          TextFieldCellModel(
            placeholder: Constants.bioTextFieldPlaceholder,
            onTextChanged: input.bio,
            isDisabled: sendingStateEnabled.asDriver(onErrorJustReturn: false)
            ),
          ButtonCellModel(
            title: screenState == .create
            ? Constants.buttonCreateActionLabelText
            : Constants.buttonUpdateActionLabelText,
            actionTitle: screenState == .create
            ? Constants.buttonCreatingActionLabelText
            : Constants.buttonUpdatingActionLabelText,
            isEnabled: buttonIsEnabled.asDriver(onErrorJustReturn: false),
            isSending: sendingStateEnabled.asDriver(onErrorJustReturn: false),
            onTap: input.sendAction
          ),
          ValidationCellModel(isHidden: validationLabelIsHidden.asDriver(onErrorJustReturn: true))
        ]
      )
    ])
  }()

  public init(user: UserVm, screenState: InputsScreenState) {
    self.user = user
    self.screenState = screenState

    login = BehaviorSubject<String>(value: user.login ?? "")
    password = BehaviorSubject<String>(value: user.password ?? "")
    email = BehaviorSubject<String>(value: user.email ?? "")
    gender = BehaviorSubject<String>(value: user.gender ?? "")
    creditCard = BehaviorSubject<String>(value: user.creditCard ?? "")
    bio = BehaviorSubject<String>(value: user.bio ?? "")
    
    input = Input(
      login: login.asObserver(),
      password: password.asObserver(),
      email: email.asObserver(),
      gender: gender.asObserver(),
      creditCard: creditCard.asObserver(),
      bio: bio.asObserver(),
      sendAction: sendAction,
      onExitScreenAction: exitScreen.asObserver()
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
  }
  
  private func bindButtonIsEnabled() {
    Observable
      .combineLatest(
        login,
        password,
        email,
        gender,
        creditCard,
        bio
      )
      .map {
        !$0.isEmpty
        && !$1.isEmpty
        && !$2.isEmpty
        && !$3.isEmpty
        && !$4.isEmpty
        && !$5.isEmpty
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
    Observable.combineLatest(
      login,
      password,
      email,
      gender,
      creditCard,
      bio
    )
      .map { [weak self] login, password, email, gender, creditCard, bio in
        guard let self = self else { return false }

        return self.validateDelegate.validate(login, .login)
        && self.validateDelegate.validate(password, .password)
        && self.validateDelegate.validate(gender, .gender)
        && self.validateDelegate.validate(email, .email)
        && self.validateDelegate.validate(gender, .creditCard)
        && self.validateDelegate.validate(bio, .bio)
      }
      .bind(to: validationResult)
      .disposed(by: disposeBag)
  }
  
  private func bindSending() {
    sendAction
      .withLatestFrom(
        Observable.combineLatest(
          login,
          password,
          email,
          gender,
          creditCard,
          bio,
          validationResult
        )
      )
      .filter { _, _, _, _, _, _, validationResult in
        validationResult
      }
      .bind { [weak self]
        login,
        password,
        email,
        gender,
        creditCard,
        bio,
        validationResult in
        guard let self = self else { return }

        self.isInValidWhileSending.accept(validationResult)
        self.sendingStateEnabled.onNext(true)
        guard self.screenState == .create else {
          self.updateUser(
            login: login,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
          )
          return
        }
        
        self.registrUser(
          login: login,
          password: password,
          email: email,
          gender: gender,
          creditCard: creditCard,
          bio: bio
        )
      }
      .disposed(by: disposeBag)
  }
  
  private func updateUser(
    login: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String
  ) {
    guard let id = user.userId else { return }
    
    self.service.changeUser(
      userId: id,
      login: login,
      password: password,
      email: email,
      gender: gender,
      creditCard: creditCard,
      bio: bio,
      completionHandler: responseResult
    )
  }
  
  private func registrUser(
    login: String,
    password: String,
    email: String,
    gender: String,
    creditCard: String,
    bio: String
  ) {
    self.service.registerUser(
      login: login,
      password: password,
      email: email,
      gender: gender,
      creditCard: creditCard,
      bio: bio,
      completionHandler: responseResult
    )
  }
  
  private func responseResult<T>(response: AFDataResponse<T>) {
    self.sendingStateEnabled.onNext(false)
    switch response.result {
    case .success(let result):
      print("\(result) \n")
      Analytics.logEvent(AnalyticsEventSignUp, parameters: [
        "userId": String(describing: user.userId),
        "message": "Register Successed"
      ])
      self.steps.accept(AppStep.clouseScreen)
      
    case .failure(let error):
      Analytics.logEvent(AnalyticsEventLogin, parameters: [
        "userId": String(describing: user.userId),
        "message": "Register faild"
      ])
      self.steps.accept(AppStep.error(text: error.localizedDescription))
    }
  }
}

private enum Constants {
  // Strings
  static let titleCellModelTitle = "InputFormsViewController.TitleCellModel.Title"
  static let loginTextFieldPlaceholder = "InputFormsViewController.LoginTextField.Placeholder"
  static let passwordTextFieldPlaceholder = "InputFormsViewController.PasswordTextField.Placeholder"
  static let genderTextFieldPlaceholder = "InputFormsViewController.GenderTextField.Placeholder"
  static let emailTextFieldPlaceholder = "InputFormsViewController.EmailTextField.Placeholder"
  static let creditCardTextFieldPlaceholder = "InputFormsViewController.CreditCardTextField.Placeholder"
  static let bioTextFieldPlaceholder = "InputFormsViewController.BioTextField.Placeholder"
  static let logIningLabelText = "ButtonViewCell.LogIning.Label.Text".localizationString
  static let buttonCreateActionLabelText = "ButtonViewCell.Create.Label.Text".localizationString
  static let buttonUpdateActionLabelText = "ButtonViewCell.Update.Label.Text".localizationString
  static let buttonCreatingActionLabelText = "ButtonViewCell.Creating.Label.Text".localizationString
  static let buttonUpdatingActionLabelText = "ButtonViewCell.Updating.Label.Text".localizationString
}
