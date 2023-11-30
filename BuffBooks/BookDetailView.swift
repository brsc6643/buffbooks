//
//  BookDetailView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/9/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct BookDetailView: View {
    //@Binding var book: Book?
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var sellerModel: SellerModel
    var id: String

     
        var body: some View {
                ScrollView {
                    VStack(alignment: .center) {
                        Spacer()
                        if sellerModel.book?.imurl != "" {
                            if let urlString = sellerModel.book?.imurl, let url = URL(string: urlString) {
                                WebImage(url: url)
                                    .resizable()
                                    .frame(width: 120, height: 170)
                                    .cornerRadius(10)
                                    .padding()
                            } else {
                                Image("placeholder_book_image")
                                    .resizable()
                                    .frame(width: 120, height: 170)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        } else {
                            Image("Book")
                                .resizable()
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                                .padding()
                        }
                       
                        VStack(alignment: .center, spacing: 10) {
                            Text(sellerModel.book?.title ?? "Unknown Title").fontWeight(.bold)
                            Text(sellerModel.book?.authors ?? "Unknown Authors")
                            Text(sellerModel.book?.desc ?? "No Description Available").lineLimit(200).multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding()
                        
//                        if sellerModel.isForSale {
//                            VStack {
//                                HStack {
//                                    Text("For sale by:")
//                                    Text("\(sellerModel.sellerName)")
//                                }
//                                HStack {
//                                    Text("Contact:")
//                                    Text("\(sellerModel.sellerContact)")
//                                }
//                                HStack {
//                                    Text("Price:")
//                                    Text("$\(sellerModel.salePrice)")
//                                }
//                                HStack {
//                                    Text("Condition:")
//                                    Text(sellerModel.saleCondition)
//                                }
//                            }
//                        }
                        
                        let bookSaleInfo = getBookSaleInfo(forBookId: id)
                        
                        List(bookSaleInfo.sellers, id: \.self) { seller in
                            VStack(alignment: .leading) {
                                Text("For sale by: \(seller.sellerName)")
                                Text("Contact: \(seller.sellerContact)")
                                Text("Price: $\(seller.price)")
                                Text("Condition: \(seller.condition)")
                            }
                        }
//                        else {
//                            Text("Uh oh! It looks like nobody is selling this book right now. If you have this book for sale, press the button below.")
//                                .font(.headline)
//                                .multilineTextAlignment(.leading)
//                                .padding()
//                        }
                        Button("Sell") {
                            sellerModel.showingSellSheet = true
                        }
                        .padding()
                        .padding()
                        .foregroundColor(.color1)
                        .font(.headline)
                        .shadow(radius: 5)
                        .background(Color.color2)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    } //end vstack
                    .sheet(isPresented: $sellerModel.showingSellSheet) {
                        SellFormView(sellerModel: sellerModel)
                    }

                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.black)
                .cornerRadius(15)
                .padding()
                .padding()
            }
        }
    }
