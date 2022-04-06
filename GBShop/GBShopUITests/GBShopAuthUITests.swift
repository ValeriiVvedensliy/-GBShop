//
//  GBShopAuthUITests.swift
//  GBShopUITests
//
//  Created by Valera Vvedenskiy on 06.04.2022.
//

import XCTest

class GBShopAuthUITests: XCTestCase {
  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }
  
  func testSuccess() {
    let tablesQuery = XCUIApplication().tables
    enterAuthData(login: "administrator", password: "12345678", tablesQuery: tablesQuery)
    let resultText = tablesQuery.tables["ProductsScreen"]

    XCTAssertNotNil(resultText)
  }
  
  func testFaild() {
    let tablesQuery = XCUIApplication().tables
    enterAuthData(login: "admin", password: "123456", tablesQuery: tablesQuery)
    let resultText = tablesQuery.staticTexts["ValidationText"]
  
    XCTAssertNotNil(resultText)
  }
  
  private func enterAuthData(login: String, password: String, tablesQuery: XCUIElementQuery) {
    let loginTextField = tablesQuery.textFields["Login"]
    loginTextField.tap()
    loginTextField.typeText(login)

    let passwordTextField = tablesQuery.textFields["Password"]
    passwordTextField.tap()
    passwordTextField.typeText(password)

    tablesQuery/*@START_MENU_TOKEN@*/.otherElements["LoginButton"]/*[[".cells.otherElements[\"LoginButton\"]",".otherElements[\"LoginButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
