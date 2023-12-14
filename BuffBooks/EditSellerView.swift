//
//  EditSellerView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/14/23.
//

import SwiftUI

struct EditSellerView: View {
    @Binding var seller: SellerInfo
    @Environment(\.presentationMode) var presentationMode
    var onSave: (SellerInfo) -> Void

    @State private var tempSeller: SellerInfo

    init(seller: Binding<SellerInfo>, onSave: @escaping (SellerInfo) -> Void) {
        _seller = seller
        _tempSeller = State(initialValue: seller.wrappedValue)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $tempSeller.sellerName)
                TextField("Contact", text: $tempSeller.sellerContact)
                TextField("Price", text: $tempSeller.price)
                TextField("Condition", text: $tempSeller.condition)
                
                Button("Save Changes") {
                    onSave(tempSeller)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Edit Listing", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
