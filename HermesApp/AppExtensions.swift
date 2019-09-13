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
    case Sirena = "sirena"
    case Humo = "humo"
    case Ventilador = "ventilador"
    
    static let values = [Bombillo, Humo, Sirena, Ventilador]
  }
  
  convenience init!(assetIdentifier: AssetIdentifier) {
    self.init(named: assetIdentifier.rawValue)
  }
  
}
