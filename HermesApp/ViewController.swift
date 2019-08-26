//
//  ViewController.swift
//  HermesApp
//
//  Created by John Edisson Castillo Hernandez on 8/9/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  // Outlets
  @IBOutlet weak var Mode: UIButton!
  @IBOutlet weak var Temporizator: UIButton!
  @IBOutlet weak var OnOff: UIButton!
  
  //properties
  var actuator:Actuator?
  var timer:Timer?
  let image = UIImage(named: "bombillo")
    var noirImage: UIImage?
  //Lifecicle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = actuator?.name
    
    noirImage = image?.noir
    // Do any additional setup after loading the view.
  }
  
  //Actions
  
  @IBAction func onOffSwitch(_ sender: Any) {
    actuator!.mode = "onOff"
    if actuator!.switchBulb {
        OnOff.setImage(image, for: .normal)
    }else {
         // noirImage is an optional UIImage (UIImage?)
        OnOff.setImage(noirImage, for: .normal)
    }
    actuator!.switchBulb.toggle()
  }
  
  @IBAction func setTimer(_ sender: Any) {
    actuator!.mode = "timer"
    alertWithTF()
    
    
  }
  
  
  @IBAction func setRomacticMode(_ sender: Any) {
    if actuator!.mode != "romantic" {
        actuator!.mode = "romantic"
        actuator!.timeLeft = 2
      OnOff.setImage(image, for: .normal)
        actuator!.level = -0.5
      for _ in 1...1 {
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.actuator!.timeLeft), repeats: false, block: { timer in
          
            self.OnOff.setImage(self.image?.decreaseBrightness(level: self.actuator!.level) , for: .normal)
          self.actuator!.level += 0.1
        })
      }
    }
  }
  
  @IBAction func setPersuationMode(_ sender: Any) {
    if actuator!.mode != "persuation" {
      actuator!.mode = "persuation"
      OnOff.setImage(image, for: .normal)
      actuator!.level = 1
      self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
        
        if(self.actuator!.switchBulb){
            self.OnOff.setImage(self.image, for: .normal)
        }else{
            self.OnOff.setImage(self.noirImage, for: .normal)
          self.actuator!.level -= 0.1
        }
        self.actuator!.switchBulb.toggle()
      })

    }else{
      timer?.invalidate()
    }
    
    
  }
  
  
    
    
    
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "Great Title", message: "Please input something", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "ON", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.actuator!.timeLeft = Int(textField.text!)!
            self.OnOff.setImage(self.image, for: .normal)
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.actuator!.timeLeft), repeats: false, block: { timer in
                self.OnOff.setImage(self.noirImage, for: .normal)
            })
        }
        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "set Minutes amoung"
            textField.textColor = .blue
        }
        //Step : 4
        alert.addAction(save)
        alert.addAction(UIAlertAction(title: "OFF", style: .default) { (alertAction) in })
        self.present(alert, animated:true, completion: nil)
    }
    
  
}

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    func decreaseBrightness(level: Float) -> UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIColorControls") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        currentFilter.setValue(level, forKey: kCIInputBrightnessKey)
        if let output = currentFilter.outputImage ,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}
