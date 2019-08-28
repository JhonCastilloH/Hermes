//
//  ActuatorCollectionViewCell.swift
//  HermesApp
//
//  Created by Usuario on 8/10/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//
import UIKit

protocol cellButtonDelegate: AnyObject{
    func didSelectButton(_ index: Int)
}

class ActuatorCollectionViewCell: UICollectionViewCell {
    weak var delegate: cellButtonDelegate?
    @IBOutlet weak var myButton: UIButton!
    var indexCell: Int?
    var actuator:Actuator?
    
    //MARK: - Actions
    func setupActuatorCell() {
        let image = UIImage(assetIdentifier: UIImage.AssetIdentifier(rawValue: actuator!.name)!)
        myButton.setBackgroundImage(image, for: .normal)
        myButton.setTitle(actuator!.name, for: .normal)
        
    }
    
    //MARK: - Action Pass back view Details
    @IBAction func actionDone(_ sender: UIButton) {
        self.delegate?.didSelectButton(indexCell!)
    }
    
    
    
}
