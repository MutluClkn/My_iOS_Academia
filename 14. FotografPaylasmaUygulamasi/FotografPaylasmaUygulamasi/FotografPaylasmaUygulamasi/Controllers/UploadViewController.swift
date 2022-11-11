//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 9.11.2022.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    let popUpMessage = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerSetup()
    }

    // Photo Picking Funcs
    func imagePickerSetup(){
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toPickImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func toPickImage(){
        var pickerConfiguration = PHPickerConfiguration()
        pickerConfiguration.filter = .images
        let pickerController = PHPickerViewController(configuration: pickerConfiguration)
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            let previousImage = imageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageView.image == previousImage else { return }
                    self.imageView.image = image
                }
            }
        } // There is an error. I can not pick the first image from the gallery.
        
    }
    
    
    // Button
    @IBAction func uploadButtonDidPress(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.popUpMessage.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Görsel yüklenemedi.")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            if let imageURL = imageURL{
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["gorselURL" : imageURL, "yorum" : self.titleTextField.text!, "tarih" : FieldValue.serverTimestamp(), "email" : Auth.auth().currentUser!.email as Any] as [String : Any]
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost){ (error) in
                                    if error != nil {
                                        self.popUpMessage.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Hata meydana geldi.")
                                    }else {
                                        self.imageView.image = UIImage(named: "addImage")
                                        self.titleTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }else {
                            self.popUpMessage.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Görsel indirilemedi.")
                        }
                    }
                }
            }
        }
    }
}
