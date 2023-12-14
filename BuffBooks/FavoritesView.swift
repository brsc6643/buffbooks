//
//  FavoritesView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/14/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List(userData.favoriteBooks, id: \.id) { book in
                // Display each favorite book
                Text(book.title)
                
            }
            .navigationTitle("Favorites")
        }
    }
}
