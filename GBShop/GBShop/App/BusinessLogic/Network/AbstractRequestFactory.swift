//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 17.02.2022.
//

import Foundation
import Alamofire

class Auth: RequestFactory {
  let errorParser: AbstractErrorParser
  let sessionManager: Session
  let queue: DispatchQueue
  let baseUrl = URL(string: "https://github.com/GeekBrainsTutorial/online-store-api")
  
  init(
    errorParser: AbstractErrorParser,
    sessionManager: Session,
    queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
      self.errorParser = errorParser
      self.sessionManager = sessionManager
      self.queue = queue
    }
}
