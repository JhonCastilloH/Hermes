//
//  Contact.swift
//  HermesApp
//
//  Created by Usuario on 9/17/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

public struct Contact {
    let id: String
    var name: String
    var mode: String
    var spaceID: String
    
    init(id: String, name: String, mode: String, spaceID: String) { // default struct initializer
        self.id = id
        self.name = name
        self.mode = mode
        self.spaceID = spaceID
    }
    
}


//"firstName": "Chris",
//"lastName": "Chang",
//"email": "soporte@mlab.com"
