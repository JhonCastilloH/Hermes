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
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var spaceNameFiled: UITextField!
  @IBOutlet weak var iconButton: UIButton!
  
  // MARK: - Properties
  var modelController : ModelController!
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
    self.spaceNameFiled.isHidden = (space?.name != "Agregar") ? true : false
    self.spaceNameLabel.isHidden = (space?.name != "Agregar") ? false : true
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dispositivos", style: .plain, target: self, action: #selector(showDevices))
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:) ))
    iconButton.addGestureRecognizer(longPress)
  }
    
    
    // MARK: - actions
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            if (space?.name != "Agregar") {
                modelController.delete(self.space!)
            }else{
                self.space?.name = self.spaceNameFiled.text!
                modelController.update(self.space!)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func showDevices(_ sender: AnyObject) {
        if let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalDevices") as? ModalViewController {
            definesPresentationContext = true
            modalViewController.modalPresentationStyle = .overCurrentContext
            modalViewController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 450)
            modalViewController.delegate = self
            self.present(modalViewController, animated: false, completion: nil)
           
        }
    }
    
    
    @IBAction func editName(_ sender: Any) {
        let button = sender as! UIButton
        if (button.titleLabel?.text == "Guardar nombre") {
            self.spaceNameFiled.isHidden = true
            self.spaceNameLabel.isHidden = false
            self.space?.name = self.spaceNameFiled.text!
            modelController.update(self.space!)
            self.editButton.setTitle("Cambiar nombre", for: .normal)
            self.spaceNameLabel.text = self.space?.name
        }else{
            self.spaceNameFiled.isHidden = false
            self.spaceNameLabel.isHidden = true
            self.editButton.setTitle("Guardar nombre", for: .normal)
        }
        
        
    }
    
    @objc func long() {
        
        print("Long press")
    }
    

}

extension SpaceViewController : modalDelegate {
    func didSelectAcceptButton(_ actuator: Actuator) {
        var actuatorNew = actuator
        actuatorNew.spaceID = space!.id
        self.space?.actuators.append(["id": actuator.id, "name": actuator.name])
        modelController.update(self.space!)
        modelController.update(actuator)
    }
    
}

