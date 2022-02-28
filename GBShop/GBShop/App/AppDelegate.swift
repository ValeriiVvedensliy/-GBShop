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
  let container: Container = {
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
    let auth = container.resolve(Auth.self)!

    auth.login(userName: "Somebody", password: "mypassword", completionHandler: responseResult)
    auth.logout(userId: 123, completionHandler: responseResult)
    auth.registerUser(
      userName: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language",
      completionHandler: responseResult
    )
    auth.changeUser(
      userId: 123,
      userName: "Somebody",
      password: "mypassword",
      email: "some@some.ru",
      gender: "m",
      creditCard: "9872389-2424-234224-234",
      bio: "This is good! I think I will switch to another language",
      completionHandler: responseResult
    )
    
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
  
  private func responseResult(response: AFDataResponse<LoginResult>) {
    switch response.result {
    case .success(let login):
      print(login)
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}

