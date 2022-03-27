//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

class AbstractRequestFactory: RequestFactory {
  let errorParser: AbstractErrorParser
  let sessionManager: Session
  let queue: DispatchQueue
  let baseUrl = URL(string: "https://stormy-refuge-30742.herokpp.com/")
  
  init(
    errorParser: AbstractErrorParser,
    sessionManager: Session,
    queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
      self.errorParser = errorParser
      self.sessionManager = sessionManager
      self.queue = queue
    }
}
