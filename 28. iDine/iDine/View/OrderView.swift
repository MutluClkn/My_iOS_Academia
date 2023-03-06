//
//  OrderView.swift
//  iDine
//
//  Created by Mutlu Çalkan on 3.03.2023.
//

//MARK: - Libraries
import SwiftUI

//MARK: - OrderView
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
                    .onDelete(perform: deleteItems)
                }
                
                Section{
                    NavigationLink("Place Order"){
                        CheckoutView()
                    }
                }
                .disabled(order.items.isEmpty)
            }
            .navigationTitle("Order")
            .toolbar{
                EditButton()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet){
        order.items.remove(atOffsets: offsets)
    }
}

//MARK: - OrderView_Previews
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
