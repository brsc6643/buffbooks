//
//  SearchView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/8/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var booksGetter = DataGetter()
    @State private var searchText = ""
    @State private var selectedBook: Book?
    
    var body: some View {
        VStack {
            SearchBarView(text: $searchText, placeholder: "Search Books")
            List(booksGetter.data) { book in
                VStack(alignment: .leading, content: {
                    Text("Title: \(book.title)")
                    Text("Author: \(book.authors)")
                })
            }
        }
        .onAppear {
            self.booksGetter.fetchBooks(query: "College")
        }
        .onChange(of: searchText) { newValue in
            self.booksGetter.fetchBooks(query: newValue)
        }
        .navigationTitle("Search")
        .navigationBarBackButtonHidden(true)
    }
}
