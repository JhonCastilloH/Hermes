//
//  ModalViewController.swift
//  HermesApp
//
//  Created by Usuario on 9/7/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

protocol modalDelegate: AnyObject{
    func didSelectAcceptButton(_ actuator: Actuator)
}

class ModalViewController: UIViewController {
    @IBOutlet weak var actuatorNameField: UITextField!
    @IBOutlet weak var actuatorIdField: UITextField!
    
    weak var delegate: modalDelegate?
    
    override func viewDidLoad() {
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //view.isOpaque = true
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            view.sendSubviewToBack(blurEffectView)
        } else {
            view.backgroundColor = .black
        }
        
    }
    

    @IBAction func tapCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAccept(_ sender: UIButton) {
        let actuator = Actuator(id: actuatorIdField.text!, name: actuatorNameField.text!, type: "", switchBulb: false, level: 0, timeLeft: 0, mode: "onOff", spaceID: "")
        self.delegate?.didSelectAcceptButton(actuator)
        dismiss(animated: true, completion: nil)
    }

}
