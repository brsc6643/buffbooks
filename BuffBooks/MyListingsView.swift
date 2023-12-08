//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    @ObservedObject var dataGetter: DataGetter
 
    var body: some View {
        List {
            ForEach(dataGetter.myListings, id: \.self) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .fontWeight(.bold)
                    Text("By \(book.authors)")
                }
            }
            .onDelete(perform: delete)
        }
        .onAppear(perform: {
            dataGetter.myListings = dataGetter.loadMyListingsFromUserDefaults()
        })
    }
        
 
    private func delete(at offsets: IndexSet) {
        dataGetter.deleteMyListing(at: offsets)
    }
}

