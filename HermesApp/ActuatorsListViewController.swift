//
//  ActuatorsListViewController.swift
//  HermesApp
//
//  Created by Usuario on 8/10/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class ActuatorsListViewController: UIViewController {
    // MARK: - Instance Outlets
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    // MARK: - Instance Properties
    var actuator:Actuator?
    var indexSelected = -1
    public var actuatorList = ActuatorList.getActuators()
    var space:Space?
    public var spaceList = SpaceList.getSpaces()
    var spaceSelected: Int?
    var actuatorSelected: Int?
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
   
    
    
}

extension ActuatorsListViewController : UICollectionViewDataSource {
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == self.collectionViewA {
            return self.actuatorList.actuators.count
         }else {
            return self.spaceList.spaces.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ActuatorCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        if collectionView == self.collectionViewA {
            cell.myButton.setTitle(self.spaceList.spaces[indexPath.item].name, for: .normal)
        }else {
            cell.actuator = self.actuatorList.actuators[indexPath.item]
            cell.setupActuatorCell()
        }
        cell.indexCell = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension ActuatorsListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}

extension ActuatorsListViewController : cellButtonDelegate{
    func didSelectButton(_ index: Int) {
        print("You selected the button cell!")
        
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "actuatorVC") as? ViewController {
            viewController.actuator = self.actuatorList.actuators[index]
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
}
