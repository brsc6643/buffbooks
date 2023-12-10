//
//  SaleInfo.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/29/23.
//

import SwiftUI

struct SellerInfo: Codable, Hashable {
    var sellerName: String
    var sellerContact: String
    var price: String
    var condition: String
}

//struct Listing: Identifiable, Codable {
//    let id: String
//    let bookName: String
//    let authors: String
//    let sellerInfo: SellerInfo
//}

func getBookSaleInfo(forBookId id: String) -> BookSaleInfo {
    let decoder = JSONDecoder()
    if let savedData = UserDefaults.standard.data(forKey: "BookSaleInfo_\(id)"),
       let bookSaleInfo = try? decoder.decode(BookSaleInfo.self, from: savedData) {
        print("Sellers: \(bookSaleInfo.sellers)")
        return bookSaleInfo
    }
    return BookSaleInfo(id: id, bookTitle: "", sellers: [])
}
