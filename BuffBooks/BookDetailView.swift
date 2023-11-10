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
    let book : Book
    @Binding var isPresented: Book?
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center) {
                if book.imurl != "" {
                    WebImage(url: URL(string: book.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10).padding()
                }
                else {
                    Image("Book").resizable().frame(width: 120, height: 170).cornerRadius(10).padding()
                }
                VStack(alignment: .center, spacing: 10) {
                    Text(book.title).fontWeight(.bold)
                    Text(book.authors)
                    Text(book.desc).lineLimit(100).multilineTextAlignment(.leading)
                }
            }
        }
        Button(action: {self.isPresented = nil}) {
            HStack {
                  Image(systemName: "xmark")
                  Text("Dismiss")
              }
              .foregroundColor(.black)
              //.background(Color.color2)
              .cornerRadius(15)
              //.frame(maxWidth: 400, maxHeight: 100)
              .padding()
            }
        }
    }

