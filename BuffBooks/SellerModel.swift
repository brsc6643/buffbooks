//
//  SellerModel.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/27/23.
//

import SwiftUI

class SellerModel : ObservableObject {
    //@Published var isForSale = false
    @Published var sellerName = ""
    @Published var sellerContact = ""
    @Published var salePrice = ""
    @Published var saleCondition = ""
    @Published var showingSellSheet = false
    @Published var sellerUsername = ""
    var book: Book?
    
    init(book: Book?) {
            self.book = book
            loadSaleInfo()
        }
     
    func loadSaleInfo() {
        guard let bookId = book?.id else { return }
        if let saleInfo = UserDefaults.standard.dictionary(forKey: "saleInfo_\(bookId)") as? [String: String] {
            //self.isForSale = true
            self.sellerName = saleInfo["name"] ?? ""
            self.sellerContact = saleInfo["contact"] ?? ""
            self.salePrice = saleInfo["price"] ?? ""
            self.saleCondition = saleInfo["condition"] ?? ""
            self.sellerUsername = saleInfo["username"] ?? "guest"
        }
    }
 
    func markAsForSale(name: String, contact: String, price: String, condition: String) {
        guard let bookId = book?.id else { return }
        let saleInfo = ["name": name, "contact": contact, "price": price, "condition": condition]
        UserDefaults.standard.set(["name": name, "contact": contact, "price": price, "condition": condition], forKey: "saleInfo_\(bookId)")
        //self.isForSale = true
        self.sellerName = name
        self.sellerContact = contact
        self.salePrice = price
        self.saleCondition = condition
        self.sellerUsername = UserDefaults.standard.string(forKey: "currentUserEmail") ?? "guest"
        book?.submittedBy = sellerUsername
    }
    
}
