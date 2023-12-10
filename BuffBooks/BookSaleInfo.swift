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
