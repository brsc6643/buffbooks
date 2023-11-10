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
                Spacer()
                if book?.imurl != "" {
                    if let urlString = book?.imurl, let url = URL(string: urlString) {
                        WebImage(url: url)
                            .resizable()
                            .frame(width: 120, height: 170)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        Image("placeholder_book_image")
                            .resizable()
                            .frame(width: 120, height: 170)
                            .cornerRadius(10)
                            .padding()
                    }
                } else {
                    Image("Book")
                        .resizable()
                        .frame(width: 120, height: 170)
                        .cornerRadius(10)
                        .padding()
                }
               
                VStack(alignment: .center, spacing: 10) {
                    Text(book?.title ?? "Unknown Title").fontWeight(.bold)
                    Text(book?.authors ?? "Unknown Authors")
                    Text(book?.desc ?? "No Description Available").lineLimit(200).multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
        }
       
        Button("Close") {
            self.book = nil 
        }
        .foregroundColor(.black)
        .cornerRadius(15)
        .padding()
    }
}
