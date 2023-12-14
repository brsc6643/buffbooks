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
    @State private var editingContent: String = ""
    @EnvironmentObject var userData: UserData

    
 
    var body: some View {
        NavigationView {
            List {
                ForEach(dataGetter.saleInformation.indices, id: \.self) { index in
                    HStack {
                        Text(dataGetter.saleInformation[index])
                        Spacer()
                        Button("Edit") {
                            editingIndex = index
                            editingContent = dataGetter.saleInformation[index]
                            isEditing = true
                        }
                    }
                }
                .onDelete(perform: delete) // Swipe-to-delete functionality
            }
            .navigationBarTitle("My Listings")
            .sheet(isPresented: $isEditing) {
                EditSaleInfoView(saleInfo: $editingContent, dataGetter: dataGetter, index: editingIndex)
            }
        }
        .onAppear{
            let currentUserEmail = userData.getCurrentUserEmail()
            dataGetter.filterListingsByEmail(currentUserEmail: currentUserEmail ?? "")
            print(userData.userEmail)
        }
    }
 
    private func delete(at offsets: IndexSet) {
        dataGetter.saleInformation.remove(atOffsets: offsets)
        dataGetter.saveSaleInformation()
    }
}
