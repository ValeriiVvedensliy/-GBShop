//
//  AppStep.swift
//  GBShop
//
//  Created by Valera Vvedenskiy on 22.03.2022.
//

import Foundation
import RxFlow

public enum AppStep: Step {
  // Authorisation 
  case authorisationRequired
  
  // Error
  case error(text: String)
  
  // Inputs Forms
  case inputsFormRequired
  
  // Main
  case mainRequired
  case clouseScreen
}

