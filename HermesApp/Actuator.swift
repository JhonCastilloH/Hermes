//
//  Actuator.swift
//  HermesApp
//
//  Created by Usuario on 8/13/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

public struct Actuator {
    let id: String
    var name: String
    var enable = false
    let type: String
    var switchBulb: Bool
    var level: Float
    var timeLeft: Int
    var mode: String
    var spaceID: String
    
    init(id: String, name: String, enable: Bool, type: String, switchBulb: Bool, level: Float, timeLeft: Int, mode: String, spaceID: String) { // default struct initializer
        self.id = id
        self.name = name
        self.enable = enable
        self.type = type
        self.switchBulb = switchBulb
        self.level = level
        self.timeLeft = timeLeft
        self.mode = mode
        self.spaceID = spaceID
    }
    
}


extension Actuator: Encodable, Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case id = "id"
        case name = "name"
        case enable = "enable"
        case type = "type"
        case switchBulb = "switchBulb"
        case level = "level"
        case timeLeft = "timeLeft"
        case mode = "mode"
        case spaceID = "spaceID"
    }
    
    public init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        
        // extracting the data
        let id: String = try container.decode(String.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let enable: Bool = try container.decode(Bool.self, forKey: .enable)
        let type: String = try container.decode(String.self, forKey: .type)
        let switchBulb: Bool = try container.decode(Bool.self, forKey: .switchBulb)
        let level: Float = try container.decode(Float.self, forKey: .level)
        let timeLeft: Int = try container.decode(Int.self, forKey: .timeLeft)
        let mode: String = try container.decode(String.self, forKey: .mode)
        let spaceID: String = try container.decode(String.self, forKey: .spaceID)
        
        // initializing our struct
        self.init(id: id, name: name, enable: enable, type: type, switchBulb: switchBulb, level: level, timeLeft: timeLeft, mode: mode, spaceID: spaceID)
    }
}

