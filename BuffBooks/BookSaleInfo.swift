//
//  BookSaleInfo.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/29/23.
//

import SwiftUI

struct BookSaleInfo: Codable {
    var id: String
    var sellers: [SellerInfo]
}
