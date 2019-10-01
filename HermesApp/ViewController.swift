//
//  ActuatorViewController.swift
//  HermesApp
//
//  Created by John Edisson Castillo Hernandez on 8/9/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class ActuatorViewController: UIViewController {

  // Outlets
  @IBOutlet weak var Temporizator: UIButton!
  @IBOutlet weak var OnOff: UIButton!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var sliderValue: UILabel!
  @IBOutlet weak var actuatorNameFiled: UITextField!
  @IBOutlet weak var actuatorNameLabel: UILabel!
    
    @IBOutlet weak var ModeButton1: UIButton!
    @IBOutlet weak var ModeButton2: UIButton!
    @IBOutlet weak var ModeButton3: UIButton!
    @IBOutlet weak var ModeButton4: UIButton!
  
  // MARK: - Properties
  var modelController : ModelController!
  var actuator:Actuator?
  var timer:Timer?
  var image = UIImage(named: "bombillo")
  var filteredImage: CIImage?
  var noirImage: UIImage?
    
  //Lifecicle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = actuator?.name
    self.actuatorNameLabel.text = actuator?.name
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction(gesture:) ))
    actuatorNameLabel.isUserInteractionEnabled = true
    actuatorNameLabel.addGestureRecognizer(tap)
    self.image = UIImage(assetIdentifier: UIImage.AssetIdentifier(rawValue: actuator!.type)!)
    OnOff.setImage(image, for: .normal)
    noirImage = image?.noir
    if (actuator!.mode == "persuation"){
        self.setPersuationMode(OnOff!)
    }
    let modeList = ActuatorList.getModeTypes(by: actuator!.type)
    let buttonList = [ModeButton1, ModeButton2, ModeButton3, ModeButton4]
    for index in 0...3 {
        if index < modeList.count {
            buttonList[index]?.isHidden = false
            buttonList[index]?.setTitle(modeList[index], for: .normal)
        }else{
            buttonList[index]?.isHidden = true
        }
    }
    
    
    if (actuator?.type == "humo" || actuator?.type == "sirena") {
        slider.isHidden = true
        sliderValue.isHidden = true
    }
  }
  
  // MARK: - actions
  @objc func tapFunction(gesture:UITapGestureRecognizer) {
    self.actuatorNameFiled.isHidden = false
    self.actuatorNameLabel.isHidden = true
    actuatorNameLabel.isUserInteractionEnabled = false
    }
    
    @IBAction func endEditName(_ sender: Any) {
        self.actuatorNameFiled.isHidden = true
        self.actuatorNameLabel.isHidden = false
        self.actuator?.name = self.actuatorNameFiled.text!
        modelController.update(self.actuator!)
        self.actuatorNameLabel.text = self.actuator?.name
        actuatorNameLabel.isUserInteractionEnabled = true
    }
    
  @IBAction func onOffSwitch(_ sender: Any) {
    timer?.invalidate()
    if actuator!.switchBulb {
        actuator!.mode = "on"
        OnOff.setImage(image, for: .normal)
    }else {
         // noirImage is an optional UIImage (UIImage?)
        actuator!.mode = "off"
        OnOff.setImage(noirImage, for: .normal)
    }
    actuator!.switchBulb.toggle()
    modelController.update(self.actuator!)
  }
  
  @IBAction func setTimer(_ sender: Any) {
    timer?.invalidate()
    actuator!.mode = "on"
    alertWithTF()
    
    
  }
  
  
  @IBAction func setRomacticMode(_ sender: Any) {
    if actuator!.mode != "romantic" {
        timer?.invalidate()
       actuator!.mode = "romantic"
       actuator!.timeLeft = 2
       OnOff.setImage(image, for: .normal)
       actuator!.level = -0.6
       self.OnOff.setImage(self.image?.decreaseBrightness(level: self.actuator!.level) , for: .normal)
       modelController.update(self.actuator!)
        
    }
  }
  
  @IBAction func setPersuationMode(_ sender: Any) {
    if actuator!.mode != "persuation" {
      actuator!.mode = "persuation"
      modelController.update(self.actuator!)
      OnOff.setImage(image, for: .normal)
      actuator!.level = 1
      self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
        
        if(self.actuator!.switchBulb){
            self.OnOff.setImage(self.image, for: .normal)
        }else{
            self.OnOff.setImage(self.noirImage, for: .normal)
        }
        self.actuator!.switchBulb.toggle()
      })

    }else{
      timer?.invalidate()
    }
  }
  
  
    @IBAction func save(_ sender: AnyObject) {
        //let spacesList = SpaceList(spaces: [], title: "Changed Home")
        self.actuator?.level = 3
        modelController.delete(self.actuator!)
        self.navigationController?.popViewController(animated: true)
    }
   
    
    @IBAction func sliderValueDidEnd(_ sender: UISlider!) {
        //originalImage = selectedPictureImageView.image
        //sender.value = sliderValue
        print("Unpressed button slider value is \(sender.value)")
        self.actuator?.level = round(slider.value)
        self.modelController.update(self.actuator!)
    }
    
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "Great Title", message: "Please input something", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "ON", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            self.actuator!.timeLeft = Int(textField.text!)!
            self.actuator!.switchBulb = true
            self.OnOff.setImage(self.image, for: .normal)
            self.modelController.update(self.actuator!)
            self.actuator!.mode = "on"
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.actuator!.timeLeft), repeats: false, block: { timer in
                self.OnOff.setImage(self.noirImage, for: .normal)
                self.actuator!.switchBulb = false
                self.actuator!.mode = "off"
                self.modelController.update(self.actuator!)
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
    
    @IBAction func sliderValueDidChange(_ sender: UISlider!) {
        let displayinPercentage = Int((sender.value/1000) * 10000)
        sliderValue.text = String(displayinPercentage)
        let beginImage = CIImage(image: self.image!)
        let filter = CIFilter(name: "CIColorControls")
        filter!.setValue(beginImage, forKey: kCIInputImageKey)
        filter!.setValue(sender.value/10, forKey: kCIInputSaturationKey)
        if let ciimage = filter!.outputImage {
            filteredImage = ciimage
            OnOff.setImage(UIImage(ciImage: filteredImage!), for: .normal)
        }
        sliderValue.text =     "\(round(slider.value))"
    }
    
    
    
    // Mark : Navigation
    @IBAction func showDetailsView(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as? DetailActuatorViewController {
            viewController.actuator = self.actuator
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
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
