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
    @Published var myListings: [BookSaleInfo] = []
    @Published var saleInformation: [String] = []
    @Published var allBookSaleInfos: [BookSaleInfo] = []
    //var bookToDelete: BookSaleInfo
 
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
                        let author = authorsArray.joined(separator: ", ") // if authors is nil
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
    
    func saveSellerInfo(forBookId id: String, sellerInfo: SellerInfo) { //appends sellerInfo to bookSaleInfo object in userdefaults at BookSaleInfo_\(id)
        var bookSaleInfo = getBookSaleInfo(forBookId: id)
        
        bookSaleInfo.sellers.append(sellerInfo)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(bookSaleInfo) {
            UserDefaults.standard.set(encoded, forKey: "BookSaleInfo_\(id)")
        }
    }
    
    //func to clear database
    func resetUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveSaleInformation() {
        UserDefaults.standard.set(saleInformation, forKey: "saleInformation")
    }
    
 
    func loadSaleInformation() {
        if let savedData = UserDefaults.standard.array(forKey: "saleInformation") as? [String] {
            saleInformation = savedData
        }
    }
    
    func updateSaleInformation(with updatedInfo: String, atIndex index: Int) {
            guard saleInformation.indices.contains(index) else { return }
            saleInformation[index] = updatedInfo
            saveSaleInformation()
        }
    
    func filterListingsByEmail(currentUserEmail: String) {
        myListings = myListings.filter { bookInfo in
            let bookSaleInfo = getBookSaleInfo(forBookId: bookInfo.id)
            return bookSaleInfo.sellers.contains(where: { $0.submittedBy == currentUserEmail})
        }
    }
    
    func fetchListingsForCurrentUser(currentUserEmail: String) -> [BookSaleInfo] {
        return allBookSaleInfos.filter { bookSaleInfo in
            bookSaleInfo.sellers.contains(where: { $0.submittedBy == currentUserEmail} )
        }
    }
    
    func saveBookSaleInfos() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(allBookSaleInfos) {
                UserDefaults.standard.set(encoded, forKey: "allBookSaleInfos")
            }
        }
     
    func loadBookSaleInfos() {
        let decoder = JSONDecoder()
        if let savedBookSaleInfos = UserDefaults.standard.object(forKey: "allBookSaleInfos") as? Data,
           let loadedBookSaleInfos = try? decoder.decode([BookSaleInfo].self, from: savedBookSaleInfos) {
            allBookSaleInfos = loadedBookSaleInfos
        }
    }
 
    init() {
        fetchBooks(query: "College") // Initial fetch with a default search query
        loadSaleInformation()
        
        //uncomment the below line to reset listing storage
        //resetUserDefaults()
    }
}
