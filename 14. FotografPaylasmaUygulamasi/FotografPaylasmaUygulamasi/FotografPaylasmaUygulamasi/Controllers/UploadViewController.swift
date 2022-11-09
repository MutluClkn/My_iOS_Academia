//
//  UploadViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 9.11.2022.
//

import UIKit
import PhotosUI

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
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
    }
    
}
