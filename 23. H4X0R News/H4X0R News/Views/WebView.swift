//
//  WebView.swift
//  H4X0R News
//
//  Created by Mutlu Çalkan on 29.11.2022.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let urlString : String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlString {
            if let url = URL(string: urlString){
                let urlRequest = URLRequest(url: url)
                uiView.load(urlRequest)
            }
        }
    }
    
}
