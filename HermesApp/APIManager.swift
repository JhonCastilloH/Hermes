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
        static let  BaseUrl = "https://hermesheroku.herokuapp.com/"
        static let  getSpacesMethod = "spaces"
        static let  getActuatorsMethod = "actuators"
        static let  updateContactsMethod = "contacts/"
        static let  ContactsUrl = "\(BaseUrl)\(updateContactsMethod)"
        static let  SpacesUrl = "\(BaseUrl)\(getSpacesMethod)"
        static let  ActuatorsUrl = "\(BaseUrl)\(getActuatorsMethod)"
    
    
    static func getSpaces(onComplete: @escaping ([Space]) -> Void){
        guard let url = URL(string: SpacesUrl) else {return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {return}
            do{
                guard let categories = try? JSONDecoder().decode([Space].self, from: data) else {return}
                onComplete(categories)
            }
            
        }).resume()
        }
    
    
    static func updateSpace(space: Space, onSuccess: @escaping(String) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: ContactsUrl + "5d7d583a219e3800176fb484") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let newPackage =  space
        
        do {
            let jsonBody = try JSONEncoder().encode(newPackage)
            request.httpBody = jsonBody
            let jsonBodyString = String(data: jsonBody, encoding: .utf8)
            print("JSON String : ", jsonBodyString!)
        } catch let err  {
            print("jsonBody Error: ",err)
        }
        
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 {
                    // email+password were good
                    
                    print("Successful")
                    
                } else {
                    // email+password were bad
                    print("Status: \(httpResponse.statusCode) and Response: \(httpResponse)")
                }
            } else {
                print("Unwrapping NSHTTPResponse failed")
            }
        }).resume()
    }
    
    static func getActiators(onComplete: @escaping ([Actuator]) -> Void){
        guard let url = URL(string: ActuatorsUrl) else {return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {return}
            do{
                guard let categories = try? JSONDecoder().decode([Actuator].self, from: data) else {return}
                onComplete(categories)
            }
            
        }).resume()
    }
        
}

