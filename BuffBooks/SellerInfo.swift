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
    var submittedBy: String
}
