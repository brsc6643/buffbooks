//
//  EditSaleInfoView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 12/9/23.
//

import SwiftUI

struct EditSaleInfoView: View {
    @Binding var saleInfo: String
    var dataGetter: DataGetter
    var index: Int
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        VStack {
            TextEditor(text: $saleInfo)
                .border(Color.gray, width: 1)
                .padding()
 
            Button("Submit") {
                dataGetter.updateSaleInformation(with: saleInfo, atIndex: index)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .navigationTitle("Edit Listing")
    }
}

