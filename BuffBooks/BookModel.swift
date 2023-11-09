//
//  BookModel.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/2/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

class DataGetter: ObservableObject {
    @Published var data = [Book]()
    
    init() {
        
        let url = "https://www.googleapis.com/books/v1/volumes?q=a"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                
                let authors = i["volumeInfo"]["authors"].array!
                
                var author = ""
                
                for j in authors {
                    
                    author += "\(j.stringValue)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue

                
                DispatchQueue.main.async {
                    
                    self.data.append(Book(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1))
                }
            }
        }.resume()
    }
}

struct Book : Identifiable {
    var id : String
    var title: String
    var authors: String
    var desc: String
    var imurl: String
    var url: String
}
