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
    //var book: Book
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    
    @StateObject var sellerModel: SellerModel
    var id: String
    var dataGetter: DataGetter
    
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
                    
                    Button(action: {
                        userData.toggleFavorite(for: sellerModel.book ?? Book(id: "", title: "", authors: "", desc: "", imurl: "", url: ""))
                            }) {
                                Label(sellerModel.book?.isFavorited ?? false ? "Unfavorite" : "Favorite", systemImage: sellerModel.book?.isFavorited ?? false ? "star.fill" : "star")
                            }
                            .padding()
                            .padding()
                
                    let bookSaleInfo = getBookSaleInfo(forBookId: id)
                    if bookSaleInfo.sellers.isEmpty {
                        Text("There are currently no students offering this book for sale. Check again later.")
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        Text("If you would like to make a listing for this book, press \"Sell\" below.")
                            .padding()
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)

                    }
                    else {
                        if (bookSaleInfo.sellers.count == 1) { Text("This book currently has 1 listing:").padding()}
                        else{
                            Text("This book currently has \(bookSaleInfo.sellers.count) listings:").padding()
                        }
                    }
                    
                        ForEach(bookSaleInfo.sellers, id: \.self) { seller in
                            VStack(alignment: .center) {
                                Text("For sale by: \(seller.sellerName)")
                                HStack{
                                    Text("Contact:")
                                    contactLink(seller.sellerContact)
                                }
                                Text("Price: $\(seller.price)")
                                Text("Condition: \(seller.condition)")
                            }
                            .padding()

                        }
                    }
            
                    Button("Sell") {
                        sellerModel.showingSellSheet = true
                    }
                    .padding()
                    .foregroundColor(.color1)
                    .font(.headline)
                    .shadow(radius: 5)
                    .background(Color.color2)
                    .cornerRadius(15)
                    .padding(.horizontal)
            

                } //end vstack
                .sheet(isPresented: $sellerModel.showingSellSheet) {
                    SellFormView(sellerModel: sellerModel, dataGetter: dataGetter, id: id, bookTitle:  sellerModel.book?.title ?? "", bookAuthors: sellerModel.book?.authors ?? "")
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
    
    @ViewBuilder
    private func contactLink(_ contact: String) -> some View {
        if contact.contains("@") {
            if let url = URL(string: "mailto:\(contact.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
               UIApplication.shared.canOpenURL(url) {
                Link(contact, destination: url)
            } else{
                Text(contact)
            }
        } else {
            Button(contact) {
                if let url = URL(string: "sms://\(contact)"), UIApplication.shared.canOpenURL(url) {
                    Link(contact, destination: url)
                }
                else {
                    Text(contact)
                }
            }
        }
    }

