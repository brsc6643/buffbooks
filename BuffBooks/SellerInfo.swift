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

func saveSellerInfo(forBookId id: String, sellerInfo: SellerInfo) {
    var bookSaleInfo = getBookSaleInfo(forBookId: id)
    
    bookSaleInfo.sellers.append(sellerInfo)
    
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(bookSaleInfo) {
        UserDefaults.standard.set(encoded, forKey: "BookSaleInfo_\(id)")
    }
}

func getBookSaleInfo(forBookId id: String) -> BookSaleInfo {
    let decoder = JSONDecoder()
    if let savedData = UserDefaults.standard.data(forKey: "BookSaleInfo_\(id)"),
       let bookSaleInfo = try? decoder.decode(BookSaleInfo.self, from: savedData) {
        return bookSaleInfo
    }
    return BookSaleInfo(id: id, sellers: [])
}
