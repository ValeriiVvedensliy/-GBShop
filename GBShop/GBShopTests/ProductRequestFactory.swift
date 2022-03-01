//
//  ProductRequestFactory.swift
//  GBShopTests
//
//  Created by Valera Vvedenskiy on 01.03.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class ProductRequestFactory: XCTestCase {
  let expectation = XCTestExpectation(description: "ProductRequestFactory")
  var errorParser: ErrorParserStub!
  var timeout: TimeInterval = 5.0
  var product: AbstractRequestFactory!
  
  override func setUp() {
    super.setUp()
    errorParser = ErrorParserStub()
    product = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  }
  
  override func tearDown() {
    super.tearDown()
    errorParser = nil
  }
  
  func testGetProducts() {
    product.getProducts(
      pageNumber: 1,
      categoryId: 123
    ) { [weak self] (response: AFDataResponse<[Product]>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }

  func testGetProduct() {
    product.getProduct(
      productId: 123
    ) { [weak self] (response: AFDataResponse<ProductDescription>) in
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
