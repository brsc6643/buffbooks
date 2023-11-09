//
//  SearchView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/8/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var books: [Book]
    @State private var searchText = ""
   
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { book in
                // You can customize the search criteria here.
                let titleContains = book.title.localizedCaseInsensitiveContains(searchText)
                let authorsContains = book.authors.localizedCaseInsensitiveContains(searchText)
                return titleContains || authorsContains
            }
        }
    }
   
    var body: some View {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search Books")
               
                List(filteredBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        VStack(alignment: .leading) {
                            Text("Title: \(book.title) \(book.authors)")
                            Text("Author: \(book.authors)")
                        }
                    }
                }
            }
            .navigationTitle("Search Books")
    }
}


