//
//  DataGetter.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/2/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

class DataGetter: ObservableObject {
    @Published var data = [Book]()
    @Published var selectedBook: Book?
    @Published var myListings: [Book] = []
    //var bookToDelete: BookSaleInfo
 
    // Fetch books with a specified query
    func fetchBooks(query: String) {
        guard !query.isEmpty, let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.data = []
            return
        }
 
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(formattedQuery)"
        guard let url = URL(string: urlString) else { return }
 
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
 
            guard let data = data else { return }
 
            do {
                let json = try JSON(data: data)
                let items = json["items"].array ?? []
 
                DispatchQueue.main.async {
                    self.data = items.compactMap { item in
                        let id = item["id"].stringValue
                        let title = item["volumeInfo"]["title"].stringValue
                        let authorsArray = item["volumeInfo"]["authors"].arrayValue.map { $0.stringValue }
                        let author = authorsArray.joined(separator: ", ") // Handles cases where authors may be nil by joining an empty array if needed
                        let description = item["volumeInfo"]["description"].stringValue
                        let imurl = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                        let webReaderLink = item["accessInfo"]["webReaderLink"].stringValue
 
                        return Book(id: id, title: title, authors: author, desc: description, imurl: imurl, url: webReaderLink)
                    }
                } 
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func saveSellerInfo(forBookId id: String, sellerInfo: SellerInfo) {
        var bookSaleInfo = getBookSaleInfo(forBookId: id)
        
        bookSaleInfo.sellers.append(sellerInfo)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(bookSaleInfo) {
            UserDefaults.standard.set(encoded, forKey: "BookSaleInfo_\(id)")
        }
    }
    
    func resetUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadMyListings() {
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "currentUserEmail") else {
            print("Email not found")
            return
        }
        
        print("Current user email: \(currentUserEmail)")
        
        myListings = data.filter { $0.submittedBy == currentUserEmail }
        
        print("Filtered books: \(myListings)")
        
    }
    
    func deleteListing(bookToDelete: Book) {
        myListings.removeAll {$0.id == bookToDelete.id}
        if let index = data.firstIndex(where: { $0.id == bookToDelete.id }) {
            data.remove(at: index)
        }
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(myListings) {
            UserDefaults.standard.set(encodedData, forKey: "myListings")
        }
    }
    
 
    init() {
        fetchBooks(query: "College") // Initial fetch with a default search query
        //uncomment the below line to reset listing storage
        //resetUserDefaults()
    }
}
