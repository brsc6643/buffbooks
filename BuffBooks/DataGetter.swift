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
    @Published var saleInformation: [String] = []
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
    
    func saveSellerInfo(forBookId id: String, sellerInfo: SellerInfo) {
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
    
 
    init() {
        fetchBooks(query: "College") // Initial fetch with a default search query
        loadSaleInformation()
        
        //uncomment the below line to reset listing storage
        //resetUserDefaults()
    }
}
