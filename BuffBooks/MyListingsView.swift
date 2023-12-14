//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    @State var listings: [BookSaleInfo]
    @StateObject var dataGetter: DataGetter
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List($listings, id: \.id) { $listing in
                VStack(alignment: .leading) {
                    Text(listing.bookTitle)
                        .font(.headline)
                    Text("Authors: \(listing.bookAuthors ?? "Unknown")")
                        .font(.subheadline)
                    ForEach($listing.sellers, id: \.self) { $seller in
                        SellerView(seller: $seller)
                            .onChange(of: seller) { _ in
                                dataGetter.saveBookSaleInfos()
                            }
                    }
                }
            }
            .navigationTitle("My Listings")
            .onAppear(perform: {print(userData.userEmail) })
        }
    }
}
