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
    @StateObject var dataGetter : DataGetter
    //@State var myListings: [BookSaleInfo] = []
 
    var body: some View {
        NavigationView {
            List(dataGetter.myListings) { book in
                VStack(alignment: .leading){
                    Text(book.title)
                    Text(book.authors)
                    .swipeActions {
                        Button(role: .destructive) {
                            dataGetter.deleteListing(bookToDelete: book)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("My Listings")
        }
        .onAppear {
            dataGetter.loadMyListings()
        }
    }
}
