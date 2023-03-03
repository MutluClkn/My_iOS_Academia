//
//  iDineApp.swift
//  iDine
//
//  Created by Mutlu Çalkan on 27.02.2023.
//

//MARK: - Frameworks
import SwiftUI

@main
//MARK: - iDineApp
struct iDineApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
