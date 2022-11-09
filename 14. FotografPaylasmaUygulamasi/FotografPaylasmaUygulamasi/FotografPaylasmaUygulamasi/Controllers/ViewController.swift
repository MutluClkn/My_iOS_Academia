//
//  ViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 9.11.2022.
//

import UIKit
import Lottie
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var loginAnimationView: LottieAnimationView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation("LoginPage", loginAnimationView)
        
        // Keyboard Hide-Show Setup
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // AnimationView Funcs
    public func setupAnimation(_ name: String, _ animationViewName: LottieAnimationView){
        animationViewName.animation = LottieAnimation.named(name)
        animationViewName.backgroundColor = .systemBackground
        animationViewName.contentMode = .scaleAspectFit
        animationViewName.loopMode = .loop
        animationViewName.play()
    }
    // Pop-Up Message Setup
    func popUpMessage(alertTitle: String, alertMesssage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMesssage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    // Keyboard Funcs
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    // Buttons
    @IBAction func loginButtonDidPress(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            // Sign in successed
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Bilgiler uyuşmuyor. Lütfen tekrar deneyiniz.")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            // Empty slot, sign in failed
            popUpMessage(alertTitle: "Hata", alertMesssage: "Eksik bilgi girdiniz.")
        }
    }
    
    @IBAction func registerButtonDidPress(_ sender: Any) {
        if emailTextField.text !=  "" && passwordTextField.text != "" {
            // Register successed
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Bu bilgilerle kayıtlı bir kullanıcı mevcut.")
                }
                else {
                    self.popUpMessage(alertTitle: "Başarılı", alertMesssage: "Kaydınız başarıyla gerçekleştirildi. Giriş yap butonuna tıklayarak giriş yapabilirsiniz.")
                }
            }
        }else{
            // Empty slot, register failed
            popUpMessage(alertTitle: "Hata", alertMesssage: "Eksik bilgi girdiniz.")
        }
    }
}


