//
//  BuyView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI


struct BuyView: View {
    @StateObject private var booksGetter = DataGetter()
    @State private var showingLogoutAlert = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ListView()
                //.navigationBarTitle("Buy")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: Button(action: {
                    showingLogoutAlert = true
                }) {
                    Text("Sign Out")
                    }
                    .buttonStyle(PlainButtonStyle())
                )
                .alert(isPresented: $showingLogoutAlert) {
                    Alert(
                        title: Text("Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign Out")) {
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                        )
                }
                .padding()
                .background(Color.color1.edgesIgnoringSafeArea(.all))
                .foregroundColor(Color.color4)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Buy")
                    .toolbarBackground(
                        Color.color2,
                        for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
    }
}


struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
