//
//  LoadingIndicator.swift
//  Flash Chat iOS13
//
//  Created by Mutlu Çalkan on 24.11.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func loadingIndicator(start: Bool, stop: Bool){
        
        if start == true{
            let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
            let spinnerIndicator = UIActivityIndicatorView(style: .large)
            spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
            spinnerIndicator.color = UIColor.black
            spinnerIndicator.startAnimating()
            alertController.view.addSubview(spinnerIndicator)
            self.present(alertController, animated: false, completion: nil)
            return
        }else if stop == true{
           // alertController.dismiss(animated: true, completion: nil);
        }
    }
}
