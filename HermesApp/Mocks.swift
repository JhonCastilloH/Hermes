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
        Actuator(id: "bombillo1", name: "bombillo", type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "ventilador1", name: "ventilador", type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio1"),
        Actuator(id: "bombillo2", name: "bombillo", type: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "bombillo3", name: "bombillo", type: "bombillo", switchBulb: false, level: 1.0, timeLeft: 4, mode: "onOff", spaceID: "spacio2"),
        Actuator(id: "sirena1", name: "sirena", type: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "ventilador2", name: "ventilador", type: "ventilador", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "spacio3"),
        Actuator(id: "bombillo4", name: "bombillo", type: "bombillo", switchBulb: false, level: 1.0, timeLeft: 4, mode: "onOff", spaceID: "spacio3"),
        //Actuator(id: "bombillo5", name: "bombillo", switchBulb: true, level: 0.9, timeLeft: 0, mode: "onOff", spaceID: "Mi Cocina"),
        //Actuator(id: "bombillo6", name: "bombillo", switchBulb: true, level: 0.5, timeLeft: 2, mode: "onOff", spaceID: "Mi Cocina"),
        //Actuator(id: "sirena2", name: "sirena", switchBulb: false, level: 1.0, timeLeft: 3, mode: "onOff", spaceID: "Mi Cocina"),
        //Actuator(id: "bombillo6", name: "bombillo", switchBulb: false, level: 1.0, timeLeft: 4, mode: "onOff", spaceID: "Mi Cocina")
      ]
        return ActuatorList(actuators: actuators, title: "mis actuadores")
    }

}



extension SpaceList {
    
    public static func getSpaces() -> SpaceList {
        let spaces = [
            Space(id: "spacio1", name: "Mi Sala", voltaje: 10, temperatura: 30, humedad: 0.6, iluminacion: 1, actuators: [["id": "bombillo1", "name": "bombillo"],["id": "ventilador1", "name": "ventilador"]]),
            Space(id: "spacio2", name: "Mi Bano", voltaje: 12.3, temperatura: 27, humedad: 0.7, iluminacion: 0.5, actuators: [["id": "bombillo2", "name": "bombillo"],["id": "bombillo3", "name": "bombillo"]]),
            Space(id: "spacio3", name: "Mi Cuarto", voltaje: 11, temperatura: 20, humedad: 0.5, iluminacion: 0.9, actuators: [["id": "sirena1", "name": "sirena"],["id": "ventilador2", "name": "ventilador"],["id": "bombillo4", "name": "bombillo"]]),
            Space(id: "spacio4", name: "Agregar", voltaje: 9, temperatura: 28, humedad: 0.7, iluminacion: 0.8, actuators: []),
            
        ]
        return SpaceList(spaces: spaces, title: "Mi Casa")
    }
    
}
