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
    
    @EnvironmentObject var order : Order
    
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
            
            Button("Order"){
                order.add(item: item)
            }
            .buttonStyle(.borderedProminent)
            
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
                .environmentObject(Order())
        }
    }
}
