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
        }  // There is an error. I can not pick the first image from the gallery.
        
    }
    
    
    // Button
    @IBAction func uploadButtonDidPress(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
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
                            print(imageURL as Any)
                        }else {
                            self.popUpMessage.popUpMessage(alertTitle: "Hata", alertMesssage: error?.localizedDescription ?? "Görsel indirilemedi.")
                        }
                    }
                }
            } // After this process, a fatal error occurs due to hangs at LoginAnimation section.
             
        }
        
    }
    
}
