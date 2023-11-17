//
//  SellFormView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/16/23.
//

import SwiftUI

struct SellFormView: View {
    @Environment(\.presentationMode) var presentationMode
    var bookId: String
    @Binding var name: String
    @Binding var contactInfo: String
    @Binding var price: String
    @Binding var condition: String
    @Binding var isForSale: Bool
 
    var body: some View {
        VStack {
            Spacer()
           
            VStack {
                
                TextField("Name (optional)", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                
                TextField("Email/Phone Number", text: $contactInfo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
                
                TextField("Price (USD)", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
 
                TextField("Condition/Notes", text: $condition)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
 
                Button("Submit") {
                    UserDefaults.standard.set(["name": name, "contactInfo": contactInfo, "price": price, "condition": condition], forKey: "saleInfo_\(bookId)")
                    isForSale = true
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.color1)
                .font(.headline)
                .shadow(radius: 5)
                .background(Color.color2)
                .cornerRadius(15)
                .padding(.horizontal)
                
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(maxWidth: .infinity)
           
            Spacer()
        }
        .padding()
    }
}
