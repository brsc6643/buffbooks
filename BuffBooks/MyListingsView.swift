//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI


struct MyListingsView: View {
    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.color1
//        UITabBar.appearance().tintColor = .color1
//        UITabBar.appearance().unselectedItemTintColor = .gray
//    }
//    
    @StateObject var dataGetter = DataGetter()
    @State var myListings: [BookSaleInfo] = []
 
    var body: some View {
        NavigationView {
            List {
                ForEach(myListings, id: \.self) { listing in
                    VStack(alignment: .leading) {
                        Text(listing.id)  // Display book identifier or title
                        // Display other relevant info
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteListing(listing)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("My Listings")
        }
        .onAppear {
            loadMyListings()
        }
    }
 
    func loadMyListings() {
        // Load listings from UserDefaults
        // This is a simplified version. You'll need to implement logic
        // to fetch only the listings made by the current user
    }
 
    func deleteListing(_ listing: BookSaleInfo) {
        // Delete the listing from UserDefaults and update myListings
    }
}
