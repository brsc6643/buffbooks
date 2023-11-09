//
//  BookDetailView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/9/23.
//

import SwiftUI

struct BookDetailView: View {
    let book : Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title: \(book.title)")
            Text("Authors: \(book.authors)")
        }
    }
}
