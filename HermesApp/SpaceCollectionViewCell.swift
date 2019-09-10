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
  func didLongSelectSpaceButton(_ index: Int)
    
}

class SpaceCollectionViewCell: UICollectionViewCell {
  weak var delegate: cellSpaceButtonDelegate?
  @IBOutlet weak var myButton: UIButton!
  var indexCell: Int?
  var space:Space?
  var clicked: Bool = false
  
  //MARK: - Actions
  func setupActuatorCell() {
    let image = UIImage(named: "space" + (clicked ? "" : "_gris"))
    myButton.setBackgroundImage(image, for: .normal)
    //myButton.setTitle(space!.name, for: .normal)
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:) ))
    myButton.addGestureRecognizer(longPress)
    }
    
    
    //MARK: - Action Pass back view Details
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            self.delegate?.didLongSelectSpaceButton(indexCell!)
        }
    }
  
  
  @IBAction func actionDone(_ sender: UIButton) {
    self.delegate?.didSelectSpaceButton(indexCell!)
  }
  
  
  
}

