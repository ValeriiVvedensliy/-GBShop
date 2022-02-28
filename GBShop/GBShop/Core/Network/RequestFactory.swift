//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

protocol RequestFactory {
  var errorParser: AbstractErrorParser { get }
  var sessionManager: Session { get }
  var queue: DispatchQueue { get }
  
  @discardableResult
  func request<T: Decodable>(
    request: URLRequestConvertible,
    completionHandler: @escaping (AFDataResponse<T>) -> Void
  ) -> DataRequest
}

extension RequestFactory {
  
  @discardableResult
  public func request<T: Decodable>(
    request: URLRequestConvertible,
    completionHandler: @escaping (AFDataResponse<T>) -> Void
  ) -> DataRequest {
    return sessionManager
      .request(request)
      .responseCodable(
        errorParser: errorParser,
        queue: queue,
        completionHandler: completionHandler
      )
  }
}
