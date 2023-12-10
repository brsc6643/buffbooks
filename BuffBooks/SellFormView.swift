//
//  SellFormView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/16/23.
//

import SwiftUI

struct SellFormView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var sellerModel: SellerModel
    
    var dataGetter: DataGetter
    var id: String
    var bookTitle: String
    var bookAuthors: String
    
    @State private var tempName: String = ""
    @State private var tempContact: String = ""
    @State private var tempPrice: String = ""
    @State private var tempCondition: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    
                    TextField("Name", text: $tempName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    
                    TextField("Email/Phone Number", text: $tempContact)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)

                    TextField("Price (USD)", text: $tempPrice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)

                    TextField("Condition/Notes", text: $tempCondition)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .padding(.bottom)

                    Button("Submit") {
                        let newSellerInfo = SellerInfo(sellerName: tempName, sellerContact: tempContact, price: tempPrice, condition: tempCondition)
                        
                        dataGetter.saveSellerInfo(forBookId: id, sellerInfo: newSellerInfo)
                        
                        let newBook = Book(id: UUID().uuidString, title: bookTitle, authors: bookAuthors, desc: "Description", imurl: "Image URL", url: "Book URL")
                                        
                        
                        let saleInfoString = "\(bookTitle)\n \(bookAuthors)\n\n For sale by: \(tempName)\n Contact: \(tempContact)\n Price: $\(tempPrice)\n Condition: \(tempCondition)\n"
                        
                        dataGetter.saleInformation.append(saleInfoString)
                                            
                        dataGetter.saveSaleInformation()
                        
                        
                        
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
                    .padding()
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


