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
    @IBOutlet weak var panelViewA: UIView!
    @IBOutlet weak var panelViewB: UIView!
    
    // MARK: - Instance Properties
    var modelController : ModelController!
    var actuator:Actuator?
    var indexSelected = -1
    public var actuatorList:ActuatorList!
    var space:Space?
    public var spaceList:SpaceList!
    var spaceSelected: Int? = 0
    var actuatorSelected: Int?
    
    let reuseIdentifierB = "actuatorCell" // also enter this string as the cell identifier in the storyboard
   let reuseIdentifierA = "spaceCell" // also enter this string as the cell identifier in the storyboard
  
    
    // MARK: - lifecicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(modelController.spacesList.title)
        spaceList = self.modelController.spacesList
        actuatorList =  modelController.get(actuatorsBy: self.spaceList.spaces[spaceSelected!].name)
        self.collectionViewA.reloadData()
        self.collectionViewB.reloadData()
        self.panelViewA.layer.borderColor = UIColor(named: "Color-1")?.cgColor
        self.panelViewA.layer.borderWidth = 2
        self.panelViewA.layer.cornerRadius = 10
        self.panelViewB.layer.borderColor = UIColor(named: "Color-1")?.cgColor
        self.panelViewB.layer.borderWidth = 2
        self.panelViewB.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        APIManager.getSpaces(onComplete: { spaces in
            self.modelController.spacesList = SpaceList(spaces: spaces, title: "Favorites")
            self.spaceList = self.modelController.spacesList
            
            APIManager.getActuators(onComplete: { actuators in
                self.modelController.actuatorList = ActuatorList(actuators: actuators, title: "Favorites")
                self.actuatorList =  self.modelController.get(actuatorsBy: self.spaceList.spaces[self.spaceSelected!].name)
                
                DispatchQueue.main.async { // Correct
                    self.collectionViewA.reloadData()
                    self.collectionViewB.reloadData()
                    self.space = self.spaceList.spaces[self.spaceSelected!]
                }
            })
        })
        
    }
    
}

extension ActuatorsListViewController : UICollectionViewDataSource {
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == self.collectionViewA {
            return self.spaceList.spaces.count
         }else {
          return self.actuatorList.actuators.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if collectionView == self.collectionViewA {
          // get a reference to our storyboard cell
          // Use the outlet in our custom class to get a reference to the UILabel in the cell
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierA, for: indexPath as IndexPath) as! SpaceCollectionViewCell
          cell.myButton.setTitle(self.spaceList.spaces[indexPath.item].name, for: .normal)
          cell.myButton.isEnabled = self.spaceList.spaces[indexPath.item].enable
          cell.space = self.spaceList.spaces[indexPath.item]
          cell.indexCell = indexPath.row
          cell.clicked = indexPath.row == spaceSelected
          cell.setupActuatorCell()
          cell.delegate = self
          return cell
        }else if (collectionView == self.collectionViewB) {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierB, for: indexPath as IndexPath) as! ActuatorCollectionViewCell
          cell.myButton.isEnabled = self.actuatorList.actuators[indexPath.item].enable
          cell.actuator = self.actuatorList.actuators[indexPath.item]
          cell.setupActuatorCell()
          cell.indexCell = indexPath.row
          cell.delegate = self
          return cell
       } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierB, for: indexPath as IndexPath) as! ActuatorCollectionViewCell
        
        return cell
      }
      
    }
  
  
  
}

extension ActuatorsListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if collectionView == self.collectionViewA {
            self.spaceSelected = indexPath.item
            space = self.spaceList.spaces[indexPath.item]
            if let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalDevices") as? ModalViewController {
                definesPresentationContext = true
                modalViewController.modalPresentationStyle = .overCurrentContext
                modalViewController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 450)
                modalViewController.isTypeSpace = true
                modalViewController.delegate = self
                self.present(modalViewController, animated: false, completion: nil)
                
            }
        }else if collectionView == self.collectionViewB {
            self.actuatorSelected = indexPath.item
            actuator = self.actuatorList.actuators[indexPath.item]
            if let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalDevices") as? ModalViewController {
                definesPresentationContext = true
                modalViewController.modalPresentationStyle = .overCurrentContext
                modalViewController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 450)
                modalViewController.isTypeSpace = false
                modalViewController.delegate = self
                self.present(modalViewController, animated: false, completion: nil)
                
            }
        }
        
        
    }
}

extension ActuatorsListViewController : cellButtonDelegate{
    func didSelectButton(_ index: Int) {
        print("You selected the button cell!")
        self.actuatorSelected = index
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "actuatorVC") as? ActuatorViewController {
          viewController.actuator = self.actuatorList.actuators[index]
          viewController.modelController = self.modelController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func didLongSelectSpaceButton(_ index: Int) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "spaceVC") as? SpaceViewController {
            viewController.modelController = self.modelController
            viewController.space = self.spaceList.spaces[index]
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

extension ActuatorsListViewController : cellSpaceButtonDelegate{
  func didSelectSpaceButton(_ index: Int) {
    print("You selected the space button cell!")
    self.spaceSelected = index
    self.actuatorList = modelController.get(actuatorsBy: self.spaceList.spaces[index].name)
    self.collectionViewB.reloadData()
    self.collectionViewA.reloadData()
  }
  
}

extension ActuatorsListViewController : modalDelegate {
    func didSelectAcceptButton(_ name: String, isTypeSpace: Bool) {
        if !isTypeSpace {
            var actuatorNew = self.actuator
            actuatorNew?.name = name
            actuatorNew?.enable = true
            modelController.update(actuatorNew!)
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "actuatorVC") as? ActuatorViewController {
                viewController.actuator = actuatorNew
                viewController.modelController = self.modelController
                if let navigator = self.navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }else {
            var spaceNew = self.space
            spaceNew?.name = name
            spaceNew?.enable = true
            modelController.update(spaceNew!)
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "spaceVC") as? SpaceViewController {
                viewController.modelController = self.modelController
                viewController.space = spaceNew
                if let navigator = self.navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
    }
}
