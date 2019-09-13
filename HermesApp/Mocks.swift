//
//  Mocks.swift
//  HermesApp
//
//  Created by Usuario on 8/13/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

extension ActuatorList {
    
  public static func getActuators() -> ActuatorList {
  var actuators:Array<Actuator> = Array()
      actuators = [
        Actuator(id: "bombillo1", name: "bombillo", enable: true, type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "humo1", name: "humo", enable: true, type: "humo", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "sirena1", name: "sirena", enable: true, type: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "ventilador1", name: "ventilador", enable: true, type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "bombillo2", name: "bombillo", enable: true, type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "humo2", name: "humo", enable: true, type: "humo", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "sirena2", name: "sirena", enable: true, type: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "ventilador2", name: "ventilador", enable: true, type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "bombillo3", name: "bombillo", enable: false, type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "humo3", name: "humo", enable: false, type: "humo", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "sirena3", name: "sirena", enable: false, type: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "ventilador3", name: "ventilador", enable: false, type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "bombillo4", name: "bombillo", enable: true, type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio4"),
        Actuator(id: "humo4", name: "humo", enable: true, type: "humo", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio4"),
        Actuator(id: "sirena4", name: "sirena", enable: true, type: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio4"),
        Actuator(id: "ventilador4", name: "ventilador", enable: true, type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio4"),
        
      ]
        return ActuatorList(actuators: actuators, title: "mis actuadores")
    }

    public static func getModeTypes(by type:String) ->[String] {
        var modes: [String] = []
        switch type {
        case "bombillo":
            modes = ["Detalles", "Temporizador", "Romantico", "Persuacion"]
        case "humo":
            modes = ["Detalles"]
        case "sirena":
            modes = ["Detalles", "Prueba", "Continuo", "Policial"]
        case "ventilador":
            modes = ["Detalles", "Temporizador", "Wave", "Fate"]
        default:
            print("Some other character")
        }
        return modes
    }
}



extension SpaceList {
    
    public static func getSpaces() -> SpaceList {
        let spaces = [
            Space(id: "spacio1", name: "Mi Sala", enable: true, voltaje: 10, temperatura: 30, humedad: 0.6, iluminacion: 1, actuators: [
                ["id": "bombillo1", "name": "bombillo"],
                ["id": "humo1", "name": "humo"],
                ["id": "sirena1", "name": "sirena"],
                ["id": "ventilador1", "name": "ventilador"]]),
            Space(id: "spacio2", name: "Mi Bano", enable: true, voltaje: 12.3, temperatura: 27, humedad: 0.7, iluminacion: 0.5, actuators: [
                ["id": "bombillo2", "name": "bombillo"],
                ["id": "humo2", "name": "humo"],
                ["id": "sirena2", "name": "sirena"],
                ["id": "ventilador2", "name": "ventilador"]]),
            Space(id: "spacio3", name: "Mi Cuarto", enable: true, voltaje: 11, temperatura: 20, humedad: 0.5, iluminacion: 0.9, actuators: [
                ["id": "bombillo3", "name": "bombillo"],
                ["id": "humo3", "name": "humo"],
                ["id": "sirena3", "name": "sirena"],
                ["id": "ventilador3", "name": "ventilador"]]),
            Space(id: "spacio4", name: "Agregar", enable: true, voltaje: 9, temperatura: 28, humedad: 0.7, iluminacion: 0.8, actuators: [
                ["id": "bombillo4", "name": "bombillo"],
                ["id": "humo4", "name": "humo"],
                ["id": "sirena4", "name": "sirena"],
                ["id": "ventilador4", "name": "ventilador"]]),
            
            
        ]
        return SpaceList(spaces: spaces, title: "Mi Casa")
    }
    
}
