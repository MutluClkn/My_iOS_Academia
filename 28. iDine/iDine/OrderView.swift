//
//  OrderView.swift
//  iDine
//
//  Created by Mutlu Çalkan on 3.03.2023.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order : Order
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ForEach(order.items) { item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                }
                
                Section{
                    NavigationLink("Place Order"){
                        Text("Check Out")
                    }
                }
            }
            .navigationTitle("Order")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
