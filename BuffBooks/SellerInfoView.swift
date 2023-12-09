//
//  SellerInfoView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/8/23.
//

import SwiftUI

struct SellerInfoView: View {
    var seller: SellerInfo
 
    var body: some View {
        Group {
            Text("Seller: \(seller.sellerName)")
            Text("Contact: \(seller.sellerContact)")
            Text("Price: \(seller.price)")
            Text("Condition: \(seller.condition)")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}
