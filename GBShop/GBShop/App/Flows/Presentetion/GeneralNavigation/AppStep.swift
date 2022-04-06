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
    
  // Products
  case productsScreenRequired
  case clouseScreen
  case detailProductScreenRequired(product: ProductDetailVisualModel)
  
  // Comment
  case commentsScreenRequired(productId: String)
}

