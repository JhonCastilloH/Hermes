//
//  LoginViewController.swift
//  HermesApp
//
//  Created by Usuario on 9/17/19.
//  Copyright © 2019 John Edisson Castillo Hernandez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet fileprivate var usernameField: UITextField!
    @IBOutlet fileprivate var passwordField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var keyImageView: UIImageView!
    
    @IBOutlet weak var boxView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    
    // MARK: - Instance Properties
    var modelController : ModelController!
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        //usernameField.text = ""
        //passwordField.text = ""
        
        let userImage = UIImage(named: "userIcon")
        let tintedImage = userImage?.withRenderingMode(.alwaysTemplate)
        userImageView.image = tintedImage
        userImageView.tintColor = UIColor(named: "Color-1")
        
        let userImage2 = UIImage(named: "keyIcon")
        let tintedImage2 = userImage2?.withRenderingMode(.alwaysTemplate)
        keyImageView.image = tintedImage2
        keyImageView.tintColor = UIColor(named: "Color-1")
        
        boxView.layer.shadowRadius = 10
        boxView.layer.shadowColor = UIColor.gray.cgColor
        boxView.layer.shadowOpacity = 0.3
        boxView.layer.shadowOffset = CGSize.zero
    
        
        button.layer.cornerRadius = 20
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = modelController.currentUser
        if currentUser != nil {
            loadHomeScreen()
        }
    }
    
    // MARK: - Actions
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! ActuatorsListViewController
        home.modelController = self.modelController
        //self.navigationController?.pushViewController(home, animated: true)
        
        let navController = UINavigationController(rootViewController: home) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.present(navController, animated:true, completion: nil)
        //self.present(home, animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let user = ["mail" : usernameField.text, "pass" : passwordField.text]
        let sv = UIViewController.displaySpinner(onView: self.view)
        modelController.loginUpInBackground(user as! [String : String], onComplete:{ success in
            UIViewController.removeSpinner(spinner: sv)
            self.modelController.grantedAccess(code: success)
            self.loadHomeScreen()
            
        }
    )}

}
