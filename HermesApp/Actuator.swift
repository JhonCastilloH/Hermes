//
//  Actuator.swift
//  HermesApp
//
//  Created by Usuario on 8/13/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

public struct Actuator {
    public var id: String
    public var name: String
    public var enable = false
    public var type: String
    public var switchBulb: Bool
    public var level: Float
    public var timeLeft: Int
    public var mode = "onOff"
    public var spaceID: String
}

