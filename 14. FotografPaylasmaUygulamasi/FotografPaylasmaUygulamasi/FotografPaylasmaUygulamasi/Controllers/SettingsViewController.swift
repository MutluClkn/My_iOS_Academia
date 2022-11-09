//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 9.11.2022.
//

import UIKit
import Lottie
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var logOutAnimationView: LottieAnimationView!
    let animationView = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.setupAnimation("logout", logOutAnimationView)
    }
    
    @IBAction func logOutButtonDidPress(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
