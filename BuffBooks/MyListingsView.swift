//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    @State var listings: [BookSaleInfo] = []
    @ObservedObject var dataGetter: DataGetter
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack{
                if listings.isEmpty {
                    VStack{
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        Text("You have not made any listings. Add a listing by searching for a book and tap \"Sell\".")
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .offset(y:-100)

                }
                else {
                    List($listings, id: \.id) { $listing in
                        VStack(alignment: .leading) {
                            Text(listing.bookTitle)
                                .font(.headline)
                            Text("Authors: \(listing.bookAuthors ?? "Unknown")")
                                .font(.subheadline)
                            ForEach($listing.sellers, id: \.self) { $seller in
                                SellerView(seller: $seller)
                                    .onChange(of: seller) { _ in
                                        dataGetter.saveBookSaleInfos()
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Listings")
            .onAppear(perform: {
                dataGetter.loadBookSaleInfos()
                userData.isSignedIn = true
                updateListings()
            })
        }
    }
    
    private func updateListings() {
        listings = dataGetter.allBookSaleInfos.filter { bookSaleInfo in
            bookSaleInfo.sellers.contains(where: { $0.submittedBy == userData.userEmail})
        }
    }
}

