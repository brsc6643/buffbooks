//
//  SellerDetailSheet.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/8/23.
//

import SwiftUI

struct SellerDetailSheet: View {
    var seller: SellerInfo
 
    var body: some View {
        VStack {
            Text("Seller Details")
                .font(.headline)
            Text("Name: \(seller.sellerName)")
            Text("Contact: \(seller.sellerContact)")
            Text("Price: \(seller.price)")
            Text("Condition: \(seller.condition)")
            // Add more details as needed
        }
        .padding()
    }
}
