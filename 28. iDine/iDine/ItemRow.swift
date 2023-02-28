//
//  ItemRow.swift
//  iDine
//
//  Created by Mutlu Çalkan on 28.02.2023.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    
    var body: some View {
        HStack{
            HStack{
                Image(item.thumbnailImage)
                Text(item.name)
            }
            Spacer()
            Text("$\(item.price)").fontWeight(.bold)
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
