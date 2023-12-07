//
//  BookModel.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/10/23.
//

import Foundation

class Book : Identifiable, Codable {
    var id : String
    var title: String
    var authors: String
    var desc: String
    var imurl: String
    var url: String
    var submittedBy: String
    
    
    init(id: String, title: String, authors: String, desc: String, imurl: String, url: String) {
        self.id = id
        self.title = title
        self.authors = authors
        self.desc = desc
        self.imurl = imurl
        self.url = url
        self.submittedBy = ""
    }
}

