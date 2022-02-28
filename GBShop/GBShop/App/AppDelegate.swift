//
//  AppDelegate.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 15.02.2022.
//

import UIKit
import Alamofire
import Swinject


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let container: Container = {
      let container = Container()
      container.register(AbstractErrorParser.self) { _ in ErrorParser() }
      container.register(Auth.self) { r in
        lazy var commonSession: Session = {
          let configuration = URLSessionConfiguration.default
          configuration.httpShouldSetCookies = false
          configuration.headers = .default
          let manager = Session(configuration: configuration)
          return manager
        }()
        let sessionQueue = DispatchQueue.global(qos: .utility)
  
        return Auth(errorParser: r.resolve(
          AbstractErrorParser.self)!,
          sessionManager: commonSession,
          queue: sessionQueue
        )
      }
  
      return container
    }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}

