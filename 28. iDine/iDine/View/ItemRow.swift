//
//  ItemRow.swift
//  iDine
//
//  Created by Mutlu Çalkan on 28.02.2023.
//

//MARK: - Libraries
import SwiftUI

//MARK: - ItemRow
struct ItemRow: View {
    let item: MenuItem
    
    let restrictColors : [String:Color] = ["D":.purple, "G":.orange, "N":.red, "S":.blue, "V":.green]
    
    var body: some View {
        HStack{
            HStack{
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("priceColor"), lineWidth: 2))
                VStack(alignment: .leading, spacing: 3){
                    Text(item.name)
                        .font(.headline)
                    HStack{
                        ForEach(item.restrictions, id: \.self){ restriction in
                            Text(restriction)
                                .font(.caption)
                                .fontWeight(.black)
                                .padding(5)
                                .background(restrictColors[restriction, default: .black])
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            Spacer()
            Text("$\(item.price)")
                .fontWeight(.black)
                .foregroundColor(Color("priceColor"))
        }
    }
}

//MARK: - ItemRow_Previews
struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
