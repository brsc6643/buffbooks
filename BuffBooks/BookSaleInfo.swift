//
//  BookSaleInfo.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/29/23.
//

import SwiftUI

struct BookSaleInfo: Codable, Hashable {
    var id: String
    var bookTitle: String
    var bookAuthors: String?
    var sellers: [SellerInfo]
}

func getBookSaleInfo(forBookId id: String) -> BookSaleInfo {
    let decoder = JSONDecoder()
    if let savedData = UserDefaults.standard.data(forKey: "BookSaleInfo_\(id)"),
       let bookSaleInfo = try? decoder.decode(BookSaleInfo.self, from: savedData) {
        print("Sellers: \(bookSaleInfo.sellers)")
        return bookSaleInfo
    }
    return BookSaleInfo(id: id, bookTitle: "", sellers: [])
}
