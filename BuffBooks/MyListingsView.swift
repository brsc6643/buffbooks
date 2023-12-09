//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    @ObservedObject var dataGetter: DataGetter
 
    var body: some View {
        NavigationView {
            List {
                ForEach(dataGetter.saleInformation, id: \.self) { saleInfo in
                    Text(saleInfo)
                }
            }
            .navigationBarTitle("My Listings")
            // ... Other view components
        }
    }
}

    
    
//        private func delete(at offsets: IndexSet) {
//            dataGetter.deleteMyListing(at: offsets)
//        }
//}

