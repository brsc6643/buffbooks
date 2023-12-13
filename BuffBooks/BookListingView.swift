//
//  BookListingView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/8/23.
//
//
//import SwiftUI
//
//struct BookListingView: View {
//    var book: Book
//    var selectSeller: (SellerInfo) -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(book.title)
//                .fontWeight(.bold)
//            Text("By \(book.authors)")
//            Divider()
//            let bookSaleInfo = getBookSaleInfo(forBookId: book.id)
//            ForEach(bookSaleInfo.sellers, id: \.self) { seller in
//                SellerInfoView(seller: seller)
//                    .onTapGesture {
//                        selectSeller(seller)
//                    }
//            }
//        }
//    }
//}
