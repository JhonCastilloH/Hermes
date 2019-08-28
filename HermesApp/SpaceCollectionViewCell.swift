//
//  SpaceCollectionViewCell.swift
//  HermesApp
//
//  Created by John Edisson Castillo Hernandez on 8/27/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

protocol cellSpaceButtonDelegate: AnyObject{
  func didSelectSpaceButton(_ index: Int)
}

class SpaceCollectionViewCell: UICollectionViewCell {
  weak var delegate: cellSpaceButtonDelegate?
  @IBOutlet weak var myButton: UIButton!
  var indexCell: Int?
  var space:Space?
  
  //MARK: - Actions
  func setupActuatorCell() {
    let image = UIImage(assetIdentifier: UIImage.AssetIdentifier(rawValue: space!.name)!)
    myButton.setBackgroundImage(image, for: .normal)
    myButton.setTitle(space!.name, for: .normal)
    
  }
  
  //MARK: - Action Pass back view Details
  @IBAction func actionDone(_ sender: UIButton) {
    self.delegate?.didSelectSpaceButton(indexCell!)
  }
  
  
  
}

