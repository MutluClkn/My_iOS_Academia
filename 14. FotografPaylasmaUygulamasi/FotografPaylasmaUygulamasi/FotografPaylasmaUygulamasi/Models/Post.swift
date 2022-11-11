//
//  Post.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Mutlu Çalkan on 11.11.2022.
//

import Foundation

struct Post{
    var email : String
    var imageURL : String
    var description : String
    
    init(email: String, imageURL: String, description: String) {
        self.email = email
        self.imageURL = imageURL
        self.description = description
    }
}
