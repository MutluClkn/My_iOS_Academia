//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Mutlu Çalkan on 24.11.2022.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //MARK: - Login Button
    @IBAction func loginPressed(_ sender: UIButton) {

        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        let spinnerIndicator = UIActivityIndicatorView(style: .large)
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)

        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if error != nil {
                    alertController.dismiss(animated: true, completion: nil);
                    self.alertMessage(alertTitle: "Error!", alertMesssage: error?.localizedDescription ?? "An error occured while login.")
                }else{
                    alertController.dismiss(animated: true, completion: nil);
                    self.performSegue(withIdentifier: Core.loginSegue, sender: self)
                }
            }
        }
    }
}
