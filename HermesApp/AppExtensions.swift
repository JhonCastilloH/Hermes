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

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
