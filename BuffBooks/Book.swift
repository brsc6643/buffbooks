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
}
