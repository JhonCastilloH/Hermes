//
//  APIManager.swift
//  HermesApp
//
//  Created by Usuario on 9/13/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import Foundation
import CoreData
import UIKit


    
enum APIManager {
        static let  BaseUrl = "http://api.dirble.com/v2/"
        static let  ApiKey = "f96e26c3b4474043f2afd83b0e"
        static let  CategoriesUrl = "\(BaseUrl)categories?token=\(ApiKey)"
        static func getSpaces(onComplete: @escaping ([Space]) -> Void){
            guard let url = URL(string: CategoriesUrl) else {return}
            
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let data = data else {return}
                do{
                    guard let categories = try? JSONDecoder().decode([Space].self, from: data) else {return}
                    onComplete(categories)
                }
                
            }).resume()
        }
        
}

