//
//  UserData.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/8/23.
//

import SwiftUI

class UserData : ObservableObject {
    @Published var userEmail: String?
    @Published var isSignedIn: Bool
    @Published var favoriteBooks: [Book] = []
    
    init(email: String? = nil) {
        self.userEmail = email
        self.isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
        loadFavorites()
    }
    
    func getCurrentUserEmail() -> String? {
        userEmail
    }
    
    func logIn() {
        isSignedIn = true
    }
    
    func logOut() {
        isSignedIn = false
    }
    
    func toggleFavorite(for book: Book) {
            if let index = favoriteBooks.firstIndex(where: { $0.id == book.id }) {
                favoriteBooks.remove(at: index)
                book.isFavorited = false
            } else {
                var newBook = book
                newBook.isFavorited = true
                favoriteBooks.append(newBook)
            }
            saveFavorites()
        }

        private func saveFavorites() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favoriteBooks) {
                UserDefaults.standard.set(encoded, forKey: "favorites_\(userEmail ?? "")")
            }
        }

        private func loadFavorites() {
            let decoder = JSONDecoder()
            if let userEmail = userEmail,
               let savedFavorites = UserDefaults.standard.data(forKey: "favorites_\(userEmail)"),
               let loadedFavorites = try? decoder.decode([Book].self, from: savedFavorites) {
                favoriteBooks = loadedFavorites
            }
        }
}



