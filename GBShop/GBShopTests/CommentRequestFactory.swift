//
//  CommentRequestFactory.swift
//  GBShopTests
//
//  Created by Valera Vvedenskiy on 07.03.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class CommentRequestFactory: XCTestCase {
  let expectation = XCTestExpectation(description: "CommentRequestFactory")
  var errorParser: ErrorParserStub!
  var timeout: TimeInterval = 5.0
  var comment: AbstractRequestFactory!
  
  override func setUp() {
    super.setUp()
    errorParser = ErrorParserStub()
    comment = AppDelegate.container.resolve(AbstractRequestFactory.self)!
  }
  
  override func tearDown() {
    super.tearDown()
    errorParser = nil
  }
  
  func testGetComments() {
    comment.getComments(
      productId: UUID().uuidString
    ) { [weak self] (response: AFDataResponse<CommentsResponse>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }

  func testAddComment() {
    comment.addComment(
      productId: UUID().uuidString,
      userId: UUID().uuidString
    ) { [weak self] (response: AFDataResponse<CommentActionResponse>) in
      switch response.result {
      case .success(_): break
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      self?.expectation.fulfill()
    }
    wait(for: [expectation], timeout: timeout)
  }
  
  func testDeleteComment() {
    comment.deleteComment(
      productId: UUID().uuidString,
      commentId: UUID().uuidString
    ) { [weak self] (response: AFDataResponse<CommentActionResponse>) in
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
