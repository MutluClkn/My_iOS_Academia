//
//  DestinationView.swift
//  H4X0R News
//
//  Created by Mutlu Çalkan on 29.11.2022.
//

import SwiftUI
import WebKit

struct DestinationView: View {
    
    let url : String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(url: "www.google.com")
    }
}


