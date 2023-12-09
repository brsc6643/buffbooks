//
//  ListView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/6/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
 
struct ListView: View {
    @ObservedObject var booksGetter: DataGetter
    @State private var searchText = ""
 
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search Books")
                    .padding(.top, 8)
 
                List(booksGetter.data) { book in
                    HStack {
                        if !book.imurl.isEmpty {
                            WebImage(url: URL(string: book.imurl)!)
                                .resizable()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                        } else {
                            Image("Book")
                                .resizable()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(book.title).fontWeight(.bold)
                            Text(book.authors)
                            Text(book.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                        }
                    }
                    .onTapGesture {
                        booksGetter.selectedBook = book
                    }
                }
                .listStyle(PlainListStyle())
            }
            .sheet(item: $booksGetter.selectedBook) { book in
                let sellerModel = SellerModel(book: book)
                BookDetailView(sellerModel: sellerModel, id: book.id, dataGetter: booksGetter)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            booksGetter.fetchBooks(query: searchText) // Perform an initial fetch with a default or empty search query
        }
        .onChange(of: searchText) { newValue in
            booksGetter.fetchBooks(query: newValue) // Fetch books with the search query
        }
    }
}
