//
//  GBShopTests.swift
//  GBShopTests
//
//  Created by Valera Vvedenskiy on 15.02.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class GBShopTests: XCTestCase {
  struct PostStub: Codable {
      let userId: Int
      let id: Int
      let title: String
      let body: String
  }

  enum ApiErrorStub: Error {
      case fatalError
  }

  struct ErrorParserStub: AbstractErrorParser {
      func parse(_ result: Error) -> Error {
          return ApiErrorStub.fatalError
      }
      
      func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
          return error
      }
  }
  var errorParser: ErrorParserStub!

  override func setUp() {
      super.setUp()
      errorParser = ErrorParserStub()
  }
  
  override func tearDown() {
      super.tearDown()
      errorParser = nil
  }
  
  func testShouldDownloadAndParse() {
    let expectation = XCTestExpectation(description: "Download https://jsonplaceholder.typicode.com/posts/1")
    
    AF
      .request("https://jsonplaceholder.typicode.com/posts/1")
      .responseCodable(errorParser: errorParser) { (response: DataResponse<PostStub, AFError>) in
        switch response.result {
        case .success(_): break
        case .failure:
          XCTFail()
        }
        expectation.fulfill()
      }
      wait(for: [expectation], timeout: 10.0)
  }
  
  func testShouldAuthLogin() {
    let url = "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/login." + "json?username=Somebody&password=mypassword"
    
    let expectation = XCTestExpectation(description: "Download " + url)
    
    AF
      .request(url)
      .responseCodable(errorParser: errorParser) { (response: DataResponse<PostStub, AFError>) in
        switch response.result {
        case .success(_): break
        case .failure:
          XCTFail()
        }
        expectation.fulfill()
      }
    wait(for: [expectation], timeout: 10.0)
  }
}

