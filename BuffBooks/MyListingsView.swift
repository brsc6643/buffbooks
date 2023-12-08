//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI
        
    struct MyListingsView: View {
        @ObservedObject var dataGetter: DataGetter
        @State private var selectedBook: Book?
     
        var body: some View {
            NavigationView {
                List(dataGetter.myListings, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(sellerModel: SellerModel(book: book), id: book.id, dataGetter: dataGetter), tag: book, selection: $selectedBook) {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .fontWeight(.bold)
                            Text("By \(book.authors)")
                        }
                    }
                    
                }
                .navigationBarTitle("My Listings")

               
            }
            .onAppear(perform: {
                dataGetter.myListings = dataGetter.loadMyListingsFromUserDefaults()
            })
        }
        
     
    private func delete(at offsets: IndexSet) {
        dataGetter.deleteMyListing(at: offsets)
    }
}

