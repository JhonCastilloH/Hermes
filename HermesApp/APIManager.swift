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
        static let  loginContactsMethod = "sessions"
        static let  SpacesUrl = "\(BaseUrl)\(getSpacesMethod)"
        static let  ActuatorsUrl = "\(BaseUrl)\(getActuatorsMethod)"
        static let  LoginUrl = "\(BaseUrl)\(loginContactsMethod)"
    
    
    static func getContact(userEmail: String, userPass: String, onComplete: @escaping (String) -> Void){
        guard let url = URL(string: LoginUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let dic = ["password":userPass, "email": userEmail]
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            request.httpBody = jsonBody
            let jsonBodyString = String(data: jsonBody, encoding: .utf8)
            print("JSON String : ", jsonBodyString!)
        } catch let err  {
            print("jsonBody Error: ",err)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                do {
                if httpResponse.statusCode == 200 {
                    // email+password were good
                    let decoded = try JSONSerialization.jsonObject(with: data!, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    // you can now cast it with the right type
                    if let dictFromJSON = decoded as? [String:String] {
                        onComplete(dictFromJSON["token"]!)
                    }
                    
                    print("Successful")
                    
                } else {
                    // email+password were bad
                    print("Status: \(httpResponse.statusCode) and Response: \(httpResponse)")
                }
                } catch let parseError as NSError {
                    print("JSON Error \(parseError.localizedDescription)")
                }
            } else {
                print("Unwrapping NSHTTPResponse failed")
            }
        }).resume()
    }
    
    static func getSpaces(onComplete: @escaping ([Space]) -> Void){
        guard let url = URL(string: SpacesUrl) else {return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {return}
            do{
                guard let categories = try? JSONDecoder().decode([Space].self, from: data) else {
                    print("Error en get spaces")
                    return
                }
                onComplete(categories)
            }
            
        }).resume()
        }
    
    
    static func updateSpace(space: Space, code: String?, onSuccess: @escaping(String) -> Void, onFailure: @escaping(Error) -> Void){
        guard var components = URLComponents(string: "\(BaseUrl)\(getSpacesMethod)/" + space.id) else {return}
        if let token = code {components.queryItems = [ URLQueryItem(name: "token", value: token)]}
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
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
    
    static func getActuators(onComplete: @escaping ([Actuator]) -> Void){
        guard let url = URL(string: ActuatorsUrl) else {return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {return}
            do{
                guard let categories = try? JSONDecoder().decode([Actuator].self, from: data) else {
                    print("Error en get actuadores")
                    return
                }
                onComplete(categories)
            }
            
        }).resume()
    }
    
    
    static func updateActuator(actuator: Actuator, code: String?, onSuccess: @escaping(String) -> Void, onFailure: @escaping(Error) -> Void){
        guard var components = URLComponents(string: "\(BaseUrl)\(getActuatorsMethod)/" + actuator.id) else {return}
        if let token = code {components.queryItems = [ URLQueryItem(name: "token", value: token)]}
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let newPackage =  actuator
        
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
        
}

