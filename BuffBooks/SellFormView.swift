//
//  SellFormView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/16/23.
//

import SwiftUI

struct SellFormView: View {
    @Environment(\.presentationMode) var presentationMode
    //var bookId: String
    
    @ObservedObject var sellerModel: SellerModel
    
    @State private var tempName: String = ""
    @State private var tempContact: String = ""
    @State private var tempPrice: String = ""
    @State private var tempCondition: String = ""
 
    
    init(sellerModel: SellerModel) {
        self.sellerModel = sellerModel
        // Initialize temporary variables with current values
        _tempName = State(initialValue: sellerModel.sellerName)
        _tempContact = State(initialValue: sellerModel.sellerContact)
        _tempPrice = State(initialValue: sellerModel.salePrice)
        _tempCondition = State(initialValue: sellerModel.saleCondition)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    
                    TextField("Name", text: $tempName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    
                    TextField("Email/Phone Number", text: $tempContact)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    
                    TextField("Price (USD)", text: $tempPrice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    
                    TextField("Condition/Notes", text: $tempCondition)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    
                    Button("Submit") {
                        sellerModel.markAsForSale(name: tempName, contact: tempContact, price: tempPrice, condition: tempCondition)
                        sellerModel.showingSellSheet = false
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
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Sell")
        .toolbarBackground(
            Color.color2,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

