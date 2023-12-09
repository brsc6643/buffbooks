//
//  MyListingsView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct MyListingsView: View {
    @ObservedObject var dataGetter: DataGetter
    @State private var isEditing = false
    @State private var editingIndex: Int = 0
 
    var body: some View {
        NavigationView {
            List {
                ForEach(dataGetter.saleInformation.indices, id: \.self) { index in
                    HStack {
                        Text(dataGetter.saleInformation[index])
                        Spacer()
                        Button("Edit") {
                            editingIndex = index
                            isEditing = true // Show the edit sheet
                        }
                    }
                }
            }
            .navigationBarTitle("My Listings")
            // Present the edit view when isEditing is true
            .sheet(isPresented: $isEditing) {
                EditSaleInfoView(saleInfo: $dataGetter.saleInformation[editingIndex], dataGetter: dataGetter)
            }
        }
    }
}


    
    
//        private func delete(at offsets: IndexSet) {
//            dataGetter.deleteMyListing(at: offsets)
//        }
//}

