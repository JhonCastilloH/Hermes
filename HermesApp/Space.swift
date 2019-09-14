//
//  Space.swift
//  HermesApp
//
//  Created by Usuario on 8/23/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

public struct Space {
    let id: String
    var name: String
    let enable: Bool
    let voltaje: Float
    let temperatura: Float
    let humedad: Float
    let iluminacion: Float
    var actuators : [[String: String]]
    
    init(id: String, name: String, enable: Bool, voltaje: Float, temperatura: Float, humedad: Float, iluminacion: Float, actuators: [[String: String]]) { // default struct initializer
        self.id = id
        self.name = name
        self.enable = enable
        self.voltaje = voltaje
        self.temperatura = temperatura
        self.humedad = humedad
        self.iluminacion = iluminacion
        self.actuators  = actuators
    }
}


extension Space: Encodable, Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case id = "id"
        case name = "name"
        case enable = "enable"
        case voltaje = "voltaje"
        case temperatura = "temperatura"
        case humedad = "humedad"
        case iluminacion = "iluminacion"
        case actuators  = "actuadores"
    }
    
    public init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        
        // extracting the data
        let id: String = try container.decode(String.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let enable: Bool = try container.decode(Bool.self, forKey: .enable)
        let voltaje: Float = try container.decode(Float.self, forKey: .voltaje)
        let temperatura: Float = try container.decode(Float.self, forKey: .temperatura)
        let humedad: Float = try container.decode(Float.self, forKey: .humedad)
        let iluminacion: Float = try container.decode(Float.self, forKey: .iluminacion)
        let actuators: [[String: String]] = try container.decode([[String: String]].self, forKey: .actuators)
        
        // initializing our struct
        self.init(id: id, name: name, enable: enable, voltaje: voltaje, temperatura: temperatura, humedad: humedad, iluminacion: iluminacion, actuators: actuators)
    }
}
