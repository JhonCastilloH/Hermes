//
//  SpaceViewController.swift
//  HermesApp
//
//  Created by John Edisson Castillo Hernandez on 8/28/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var spaceNameLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var illuminationLabel: UILabel!
  @IBOutlet weak var voltageLabel: UILabel!
  
  // MARK: - Properties
  var space:Space? = nil
  
  // MARK: - lifecicle
    override func viewDidLoad() {
      super.viewDidLoad()
      self.setupView()
        // Do any additional setup after loading the view.
    }
  
  func setupView(){
    self.spaceNameLabel.text = space?.name
    self.temperatureLabel.text = "\(space?.temperatura ?? 0)" + "ºC"
    self.humidityLabel.text = "\(String(describing: space!.humedad))" + "mm"
    self.voltageLabel.text = "\(String(describing: space!.voltaje))" + "V"
    self.illuminationLabel.text = "\(String(describing: space!.iluminacion))" + "lm"
  }


}
