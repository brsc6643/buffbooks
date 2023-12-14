//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    var listings: [BookSaleInfo]
    @EnvironmentObject var userData: UserData
 
    var body: some View {
        NavigationView {
            List(listings, id: \.id) { listing in
                VStack(alignment: .leading) {
                    Text(listing.bookTitle)
                        .font(.headline)
                    Text("Authors: \(listing.bookAuthors ?? "Unknown")")
                        .font(.subheadline)
                    ForEach(listing.sellers, id: \.self) { seller in
                        if userData.getCurrentUserEmail() == seller.submittedBy {
                            SellerView(seller: seller)
                        }
                    }
                }
            }
            .navigationTitle("My Listings")
        }
    }
}
