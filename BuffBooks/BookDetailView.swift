//
//  BookDetailView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/9/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct BookDetailView: View {
    @Binding var book: Book?
   
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                // Safely unwrap `book` and provide a default value for `imurl` if `book` is `nil`
                if book?.imurl != "" {
                    // Safely unwrap the URL since `imurl` is not guaranteed to be a valid URL
                    if let urlString = book?.imurl, let url = URL(string: urlString) {
                        WebImage(url: url)
                            .resizable()
                            .frame(width: 120, height: 170)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        Image("placeholder_book_image") // Replace with a placeholder image if URL is not valid
                            .resizable()
                            .frame(width: 120, height: 170)
                            .cornerRadius(10)
                            .padding()
                    }
                } else {
                    Image("Book") // Default image when `imurl` is empty or `nil`
                        .resizable()
                        .frame(width: 120, height: 170)
                        .cornerRadius(10)
                        .padding()
                }
               
                // Use optional chaining with default values for other properties
                VStack(alignment: .center, spacing: 10) {
                    Text(book?.title ?? "Unknown Title").fontWeight(.bold)
                    Text(book?.authors ?? "Unknown Authors")
                    Text(book?.desc ?? "No Description Available").lineLimit(100).multilineTextAlignment(.leading)
                }
                .padding()
            }
        }
       
        Button("Close") {
            self.book = nil // This sets the `@Binding var book` to `nil` to dismiss the sheet
        }
        .foregroundColor(.black)
        .cornerRadius(15)
        .padding()
    }
}
