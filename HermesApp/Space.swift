//
//  Space.swift
//  HermesApp
//
//  Created by Usuario on 8/23/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

public struct Space {
    public var id: String
    public var name: String
    public var enable = false
    public var voltaje: Float
    public var temperatura: Float
    public var humedad: Float
    public var iluminacion: Float
    public var actuators : [[String: String]]
}
