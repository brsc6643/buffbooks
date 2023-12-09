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
    @Environment(\.presentationMode) var presentationMode
 
    @State private var sellerName: String = ""
    @State private var sellerContact: String = ""
    @State private var price: String = ""
    @State private var condition: String = ""
 
    // Parse the saleInfo string to initialize the state variables
    private func parseSaleInfo() {
        let components = saleInfo.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespaces) }
        if components.count >= 4 {
            // Assuming the format is "Seller: [name], Contact: [contact], Price: [price], Condition: [condition]"
            sellerName = components[1].replacingOccurrences(of: "For Sale By: ", with: "")
            sellerContact = components[2].replacingOccurrences(of: "Contact: ", with: "")
            price = components[3].replacingOccurrences(of: "Price: ", with: "")
            condition = components[4].replacingOccurrences(of: "Condition: ", with: "")
        }
    }
 
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $sellerName)
                    .multilineTextAlignment(.center)
                TextField("Contact", text: $sellerContact)
                    .multilineTextAlignment(.center)
                TextField("Price", text: $price)
                    .multilineTextAlignment(.center)
                TextField("Condition", text: $condition)
                    .multilineTextAlignment(.center)
            }
            Button("Save") {
                // Reassemble the saleInfo string
                saleInfo = "Name: \(sellerName)\n Contact: \(sellerContact)\n Price: \(price)\n Condition: \(condition)\n"
                
                
                dataGetter.saveSaleInformation()
                
                
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit Sale Info")
        .onAppear(perform: parseSaleInfo) // Parse when the view appears
    }
}
