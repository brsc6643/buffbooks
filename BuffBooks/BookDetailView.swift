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
    @Binding var book: Book?
    
    @State private var showingSellSheet = false
    @State private var isForSale = false
    @State private var saleName = ""
    @State private var saleContactInfo = ""
    @State private var salePrice = ""
    @State private var saleCondition = ""
     
        var body: some View {
                ScrollView {
                    VStack(alignment: .center) {
                        Spacer()
                        if book?.imurl != "" {
                            if let urlString = book?.imurl, let url = URL(string: urlString) {
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
                            Text(book?.title ?? "Unknown Title").fontWeight(.bold)
                            Text(book?.authors ?? "Unknown Authors")
                            Text(book?.desc ?? "No Description Available").lineLimit(200).multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding()
                        
                        if isForSale {
                            VStack {
                                if (saleName != "") {
                                    HStack {
                                        Text("For sale by")
                                        Text(saleName)
                                    }
                                }
                                HStack {
                                    Text("Contact")
                                    Text(saleContactInfo)
                                }
                                HStack {
                                    Text("Price:")
                                    Text("$\(salePrice)")
                                }
                                HStack {
                                    Text("Condition:")
                                    Text(saleCondition)
                                }
                            }
                        }
                        else {
                            Text("Uh oh! It looks like nobody is selling this book right now. If you have this book for sale, press the button below.")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                        Button("Sell") {
                            showingSellSheet = true
                        }
                        .padding()
                        .foregroundColor(.color1)
                        .font(.headline)
                        .shadow(radius: 5)
                        .background(Color.color2)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    } //end vstack
                    .sheet(isPresented: $showingSellSheet) {
                        SellFormView(bookId: book?.id ?? "", name: $saleName, contactInfo : $saleContactInfo, price: $salePrice, condition: $saleCondition, isForSale: $isForSale)
                    }
                    .onAppear {
                        if let bookId = book?.id, let saleInfo = UserDefaults.standard.dictionary(forKey: "saleInfo_\(bookId)") as? [String: String] {
                            self.isForSale = true
                            self.salePrice = saleInfo["price"] ?? ""
                            self.saleCondition = saleInfo["condition"] ?? ""
                        }
                }
               
                Button("Close") {
                    self.book = nil
                }
                .foregroundColor(.black)
                .cornerRadius(15)
                .padding()
            }
        }
    }
