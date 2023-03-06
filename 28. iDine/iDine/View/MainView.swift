//
//  MainView.swift
//  iDine
//
//  Created by Mutlu Çalkan on 3.03.2023.
//

//MARK: - Libraries
import SwiftUI

//MARK: - MainView
struct MainView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            
            OrderView()
                .tabItem{
                    Label("Order", systemImage: "cart")
                }
            
        }
    }
}

//MARK: - MainView_Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
