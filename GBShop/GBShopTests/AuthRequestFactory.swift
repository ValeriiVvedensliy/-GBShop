//
//  AuthRequestFactory.swift
//  GBShopTests
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthRequestFactory: XCTestCase {

  let expectation = XCTestExpectation(description: "AuthRequestFactory")
  var errorParser: ErrorParserStub!
  var timeout: TimeInterval = 5.0
  var auth: AbstractRequestFactory!
  
  override func setUp() {
      super.setUp()
      errorParser = ErrorParserStub()
      auth = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  }

  override func tearDown() {
      super.tearDown()
      errorParser = nil
  }

  func testLogin() {
    auth.login(
      login: "Somebody",
      password: "mypassword"
    ) { [weak self] (response: AFDataResponse<LoginResult>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }

  func testLogout() {
    auth.logout(
      userId: "123"
    ) { [weak self] (response: AFDataResponse<ProfileResult>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }

  func testRegisterUser() {
    auth.registerUser(
      login: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language"
    ) { [weak self] (response: AFDataResponse<ProfileResult>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }
  
  func testEditProfile() {
    auth.changeUser(
      userId: "123",
      login: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language"
    ) { [weak self] (response: AFDataResponse<ProfileResult>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }
}
