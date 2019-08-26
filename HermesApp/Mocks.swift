//
//  Mocks.swift
//  HermesApp
//
//  Created by Usuario on 8/13/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

extension ActuatorList {
    
    public static func getActuators() -> ActuatorList {
        let actuators = [
            Actuator(name: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff"),
            Actuator(name: "despertdor", switchBulb: true, level: 0.5, timeLeft: 2, mode: "onOff"),
            Actuator(name: "romantico", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff"),
            Actuator(name: "bombillo", switchBulb: false, level: 1.0, timeLeft: 4, mode: "onOff")
        ]
        return ActuatorList(actuators: actuators, title: "Mi Sala")
    }

}



extension SpaceList {
    
    public static func getSpaces() -> SpaceList {
        let spaces = [
            Space(name: "Mi Sala", voltaje: 12.3, temperatura: 30, humedad: 0.7, iluminacion: 0.5),
            Space(name: "Mi Bano", voltaje: 12.3, temperatura: 30, humedad: 0.7, iluminacion: 0.5),
            Space(name: "Mi Cuarto", voltaje: 12.3, temperatura: 30, humedad: 0.7, iluminacion: 0.5),
            Space(name: "Mi Cocina", voltaje: 12.3, temperatura: 30, humedad: 0.7, iluminacion: 0.5),
        ]
        return SpaceList(spaces: spaces, title: "Mi Casa")
    }
    
}
