//
//  ModelController.swift
//  HermesApp
//
//  Created by Usuario on 9/4/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

class ModelController {
    var spacesList = SpaceList.getSpaces()
    var actuatorList = ActuatorList.getActuators()
    
    var favorites = SpaceList(spaces: [], title: "Favorites")
    
    func update(_ space: Space) {
        for (index, old) in spacesList.spaces.enumerated() {
            if old.id == space.id {
                spacesList.spaces[index] = space
                break
            }
        }
    }
    
    func delete(_ space: Space) {
        for (index, old) in spacesList.spaces.enumerated() {
            if old.name == space.name {
                spacesList.spaces.remove(at: index)
                break
            }
        }
    }
    
    func get(actuatorsBy spaceName:String)-> ActuatorList {
        let selectedSpace:Space = spacesList.spaces.filter{ $0.name == spaceName }[0]
        var actuators = [Actuator]()
        for actuator in selectedSpace.actuators {
            actuators.append(actuatorList.actuators.filter{ $0.id == actuator["id"] }[0])
        }
        return ActuatorList(actuators: actuators, title: "mis actuadores")
    }
    
    func update(_ actuator: Actuator) {
        let index = spacesList.spaces.firstIndex(where: { $0.id == actuator.spaceID})!
        if let index2 = spacesList.spaces[index].actuators.firstIndex(where: { $0["id"] == actuator.id}){
            spacesList.spaces[index].actuators[index2]["name"] = actuator.name
        }
       
        for (index, old) in actuatorList.actuators.enumerated() {
            if old.id == actuator.id {
                actuatorList.actuators[index] = actuator
                break
            }
        }
    }
    
    func delete(_ actuator: Actuator) {
        let index = spacesList.spaces.firstIndex(where: { $0.id == actuator.spaceID})!
        spacesList.spaces[index].actuators = spacesList.spaces[index].actuators.filter{ $0["id"] != actuator.id}
        
        for (index, old) in actuatorList.actuators.enumerated() {
            if old.id == actuator.id {
                actuatorList.actuators.remove(at: index)
                break
            }
        }
    }
    
    
}
