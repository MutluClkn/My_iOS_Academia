//
//  ContentView.swift
//  iDine
//
//  Created by Mutlu Çalkan on 27.02.2023.
//

//MARK: - Frameworks
import SwiftUI

//MARK: - ContentView
struct ContentView: View {
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(menu) { section in
                    Section(section.name){
                        ForEach(section.items) { item in
                            NavigationLink{
                                ItemDetail(item: item)
                            } label: {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

//MARK: - ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
