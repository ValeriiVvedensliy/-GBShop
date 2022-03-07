//
//  BasketRequestFactory.swift
//  GBShopTests
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//


import XCTest
import Alamofire
@testable import GBShop

class BasketRequestFactory: XCTestCase {
  let expectation = XCTestExpectation(description: "BasketRequestFactory")
  var errorParser: ErrorParserStub!
  var timeout: TimeInterval = 5.0
  var basket: AbstractRequestFactory!
  
  override func setUp() {
    super.setUp()
    errorParser = ErrorParserStub()
    basket = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  }
  
  override func tearDown() {
    super.tearDown()
    errorParser = nil
  }
  
  func testAddProductToBasket() {
    basket.addProduct(
      productId: UUID().uuidString
    ) { [weak self] (response: AFDataResponse<BasketResponse>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }
  
  func testDeleteProductFromBasket() {
    basket.deleteProduct(
      productId: UUID().uuidString
    ) { [weak self] (response: AFDataResponse<BasketResponse>) in
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
