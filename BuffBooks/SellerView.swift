//
//  SellerView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/14/23.
//

import SwiftUI

struct SellerView: View {
    @Binding var seller: SellerInfo
    @State private var showingEditView = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Seller: \(seller.sellerName)")
            Text("Contact: \(seller.sellerContact)")
            Text("Price $\(seller.price)")
            Text("Condition: \(seller.condition)")
        }
        .padding()
        .onTapGesture {
            showingEditView = true
        }
        .sheet(isPresented: $showingEditView) {
            EditSellerView(seller: $seller) { updatedSeller in
                seller = updatedSeller
            }
        }
    }
}
