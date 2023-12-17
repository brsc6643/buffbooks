//
//  FavoritesView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/14/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userData: UserData
    var booksGetter: DataGetter

    var body: some View {
        NavigationView {
            VStack {
                if userData.favoriteBooks.isEmpty {
                    VStack{
                        Image(systemName: "star")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        Text("You have not favorited any books. Add a favorite by searching for a book and tap \"Favorite\".")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .offset(y:-100)
                    
                }
                else {
                    List(userData.favoriteBooks) { book in
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
            }
            .navigationTitle("Favorites")
            }
        }
    }

