//
//  DetailActuatorViewController.swift
//  HermesApp
//
//  Created by Usuario on 9/15/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class DetailActuatorViewController: UIViewController {

     //MARK: - Outlets
    @IBOutlet weak var actuatorName: UILabel!
    @IBOutlet weak var actuatorState: UILabel!
    @IBOutlet weak var actuatorLevel: UILabel!
    @IBOutlet weak var actuatorMode: UILabel!
    
    
     //MARK: - Properties
    var actuator:Actuator?
    
    
     //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actuatorName.text = self.actuator!.name
        self.actuatorState.text = self.actuator!.switchBulb ? "Encendido" : "Apagado"
        self.actuatorLevel.text = String(self.actuator!.level)
        self.actuatorMode.text = self.actuator!.mode
    }
    
    

 

}
