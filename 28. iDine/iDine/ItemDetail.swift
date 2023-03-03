//
//  ItemDetail.swift
//  iDine
//
//  Created by Mutlu Çalkan on 1.03.2023.
//

//MARK: - Frameworks
import SwiftUI

//MARK: - ItemDetail
struct ItemDetail: View {
    let item : MenuItem
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("By \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Text(item.description)
                .padding()
            
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - ItemDetail_Previews
struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ItemDetail(item: MenuItem.example)
        }
    }
}
