//
//  AppExtensions.swift
//  HermesApp
//
//  Created by Usuario on 8/25/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//
import UIKit

extension UIImage {
  
  enum AssetIdentifier: String {
    case Bombillo = "bombillo"
    case Ventilador = "ventilador"
    case Sirena = "sirena"
    
    static let values = [Bombillo, Ventilador, Sirena]
  }
  
  convenience init!(assetIdentifier: AssetIdentifier) {
    self.init(named: assetIdentifier.rawValue)
  }
  
}
